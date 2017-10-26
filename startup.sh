#stop all threads
kill  -9  `ps -ef|grep -E "StartupPosPlusServer|StartupInvokeServer|StartupPubSubServer|Bootstrap"|awk '{print $2}'`
#delete logs
cd /usr/local/rrd/rrd-posplus-server/logs/
rm  -rf rrdPosPlusServer.log.*.log

cd /usr/local/rrd/rrd-pubsub-server/logs/
rm -rf rrdPubSubServer.log.*.log

cd /usr/local/rrd/rrd-invoke-server/logs/
rm -rf rrdInvokeServer.log.*.log

echo "services starting!!!!!"
#start invoke
cd /usr/local/rrd/rrd-invoke-server
rm -rf init.sh
cp ../invoke.sh .
mv invoke.sh  init.sh
./init.sh start
#tailf  logs/rrdInvokeServer.log
#start posplus.sh
cd /usr/local/rrd/rrd-posplus-server
rm -rf init.sh
cp ../posplus.sh .
mv posplus.sh init.sh
./init.sh start
#tailf  logs/rrdPosPlusServer.log
#start pubsub.sh
cd  /usr/local/rrd/rrd-pubsub-server
rm -rf init.sh
cp ../pubsub.sh .
mv pubsub.sh  init.sh
./init.sh start
#start app
cd /usr/local/tomcat/bin/
#./shutdown.sh
#./shutdown.sh
#./shutdown.sh
./startup.sh
#tailf  logs/rrdPubSubServer.log

#start operator
#制作公钥匙
#首先登入一台linux服务器，此台做为母机（即登入其他linux系统用这台做为入口）；执行一行命令生成key文件：ssh-keygen -t rsa
#在母机上，进入/roo/.ssh目录，找到id_rsa.pub该文件，这个文件就是刚才执行ssh-keygen所生成的公钥key文件。
#用scp命令，将母机产生的key拷一份到远程的linux服务器上，并命名成authorized_keys；scp ~/.ssh/id_rsa.pub  root@192.168.1.113:/root/.ssh/authorized_keys。这一步的操作需要手动输入密码。
#现在为止，你已完成了所有的操作；可在母机通过ssh root@192.168.1.113 你会发现不在用输放密码了。相同的scp命令也是一样的情况，无需手动输入密码。
ssh root@172.20.21.176
cd  /usr/local/approot/rrd/
echo "operator start finish!!!!!!!"
sh operator.sh


ps -ef|grep -E "StartupPosPlusServer|StartupInvokeServer|StartupPubSubServer"|awk '{print $NF}'
ps -ef|grep  Bootstrap|awk '{print $17}'
echo "services start finish!!!!!!!"






