#/bin/sh
Device=$1
DISK=$2
case $DISK in
         rrqm)
            iostat -dxmt 1 2 |grep "\b$Device\b"|sed -n '$p'|tail -1|awk '{print $2}'
            ;;
         wrqm)
            iostat -dxmt 1 2 |grep "\b$Device\b"|sed -n '$p'|tail -1|awk '{print $3}'
            ;;
          rps)
            iostat -dxmt 1 2 |grep "\b$Device\b"|sed -n '$p'|tail -1|awk '{print $4}'
            ;;
          wps)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $5}'
            ;;
        rMBps)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $6}'
            ;;
        wMBps)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $7}'
            ;;
        avgrq-sz)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $8}'
            ;;
        avgqu-sz)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $9}'
            ;;
        await)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $10}'
            ;;
        svctm)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $13}'
            ;;
         util)
            iostat -dxmt 1 2 |grep "\b$Device\b" |sed -n '$p'|tail -1|awk '{print $14}'
            ;;
esac

