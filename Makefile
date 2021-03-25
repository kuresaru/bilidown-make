include config.mk

UA := -H 'User-Agent: Mozilla/5.0'
ifneq ($(AUTH),)
COOKIE := -H 'Cookie: SESSDATA=$(AUTH)'
endif

video_info_av%.txt:
	@echo 获取av$*信息
	curl -s $(COOKIE) $(UA) https://api.bilibili.com/x/web-interface/view?aid=$* \
		| ./JSON.sh -b > $@

video_info_BV%.txt:
	@echo 获取BV$*信息
	curl -s $(COOKIE) $(UA) https://api.bilibili.com/x/web-interface/view?bvid=BV$* \
		| ./JSON.sh -b > $@

video_stream_info_av%.txt: video_info_av%.txt
	@echo 获取av$*音视频流
	AID="$$(echo $* | cut -d_ -f1)" && \
		CID="$$(cat $< | awk '/\["data","cid"\]/{print $$2}')" && \
		curl -s $(COOKIE) $(UA) "https://api.bilibili.com/x/player/playurl?avid=$$AID&cid=$$CID&fnval=16&fourk=1" \
			| ./JSON.sh -b > $@

video_stream_info_BV%.txt: video_info_BV%.txt
	@echo 获取BV$*音视频流
	BVID="$$(echo $* | cut -d_ -f1)" && \
		CID="$$(cat $< | awk '/\["data","cid"\]/{print $$2}')" && \
		curl -s $(COOKIE) $(UA) "https://api.bilibili.com/x/player/playurl?bvid=$$BVID&cid=$$CID&fnval=16&fourk=1" \
			| ./JSON.sh -b > $@

%_video.m4s: video_stream_info_%.txt
	@echo 下载$*视频流
	curl $(COOKIE) $(UA) -H 'Referer: https://www.bilibili.com/' "$(shell ./decode_url.sh video $<)" > $@

%_audio.m4s: video_stream_info_%.txt
	@echo 下载$*音频流
	curl $(COOKIE) $(UA) -H 'Referer: https://www.bilibili.com/' "$(shell ./decode_url.sh audio $<)" > $@

%.mp4: %_video.m4s %_audio.m4s
	@echo 合并$*
	ffmpeg -i $*_video.m4s -i $*_audio.m4s -c:v copy -c:a copy $@

clean:
	rm -f video_info_*.txt video_stream_info_*.txt *_video.m4s *_audio.m4s

.PHONY: clean