#!/bin/bash
sleep 10s
#如果java提供了上下线接口，请使用java接口，bootstrap默认3.0.2开始支持_HB_接口
curl -s "http://127.0.0.1/_HB_?service=online"
#如果java应用没有提供上下线接口，可以使用tengine的updown
curl -s -X POST "http://127.0.0.1/eW91emFuCg==/hc"
sleep 1s
