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
#������Կ��
#���ȵ���һ̨linux����������̨��Ϊĸ��������������linuxϵͳ����̨��Ϊ��ڣ���ִ��һ����������key�ļ���ssh-keygen -t rsa
#��ĸ���ϣ�����/roo/.sshĿ¼���ҵ�id_rsa.pub���ļ�������ļ����Ǹղ�ִ��ssh-keygen�����ɵĹ�Կkey�ļ���
#��scp�����ĸ��������key��һ�ݵ�Զ�̵�linux�������ϣ���������authorized_keys��scp ~/.ssh/id_rsa.pub  root@192.168.1.113:/root/.ssh/authorized_keys����һ���Ĳ�����Ҫ�ֶ��������롣
#����Ϊֹ��������������еĲ���������ĸ��ͨ��ssh root@192.168.1.113 ��ᷢ�ֲ�������������ˡ���ͬ��scp����Ҳ��һ��������������ֶ��������롣
ssh root@172.20.21.176
cd  /usr/local/approot/rrd/
echo "operator start finish!!!!!!!"
sh operator.sh


ps -ef|grep -E "StartupPosPlusServer|StartupInvokeServer|StartupPubSubServer"|awk '{print $NF}'
ps -ef|grep  Bootstrap|awk '{print $17}'
echo "services start finish!!!!!!!"






