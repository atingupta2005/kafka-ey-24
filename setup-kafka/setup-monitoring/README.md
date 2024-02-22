# Kafka metrics monitoring with Prometheus and Grafana

- Prometheus is a time series database to capture real time metrics from any application over http
- Grafana is a rich visualization tool on top of data stored in Prometheus.
- Though Prometheus comes with an inbuilt UI but its very naive as compared to Grafana


## Basic installations
 - Kafka
 - Prometheus
 - Prometheus jmx exporter java agent : https://github.com/prometheus/jmx_exporter
 - Grafana : https://grafana.com/docs/grafana/latest/setup-grafana/installation/rpm/


## Prometheus installation
sudo apt update
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
cd /tmp/
wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
tar -xvf prometheus-2.46.0.linux-amd64.tar.gz
cd prometheus-2.46.0.linux-amd64

sudo mv console* /etc/prometheus

sudo mv prometheus.yml /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus
sudo mv prometheus /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo cat /etc/prometheus/prometheus.yml

sudo cp prometheus.service /etc/systemd/system/prometheus.service

sudo systemctl daemon-reload

sudo systemctl start prometheus

sudo systemctl enable prometheus

sudo systemctl status prometheus

curl http://localhost:9090

sudo apt install -y apt-transport-https
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana

sudo systemctl enable --now grafana-server

curl http://localhost

sudo systemctl stop grafana-server
sudo grafana-cli admin reset-admin-password grafana@123
sudo systemctl start grafana-server


## Kafka configuration
echo "export JMX_PORT=9998" >> zookeeper-server-start.sh
echo "export JMX_PROMETHEUS_PORT=7072" >> zookeeper-server-start.sh

echo "export JMX_PORT=9999" >> kafka-server-start.sh
echo "export JMX_PROMETHEUS_PORT=7071" >> kafka-server-start.sh

nano kafka-run-class.sh
# JMX settings
if [ -z “$KAFKA_JMX_OPTS” ]; then
KAFKA_JMX_OPTS=”-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost -Djava.net.preferIPv4Stack=true -javaagent:/home/prometheus/jmx_prometheus_javaagent-0.17.2.jar=$JMX_PROMETHEUS_PORT:/home/prometheus/kafka-2_0_0.yml”
fi

Start your zookeeper and kafa servers. If successfully up, you should be able to see jmx metrics on below links.
http://localhost:7071/metrics [kafka jmx metrics]
http://localhost:7072/metrics [zookeeper jmx metrics]


nano /etc/prometheus/prometheus.yml
- job_name: "kafka-server"
    static_configs:
      - targets: ["localhost:7071"]
  - job_name: "zookeeper-server"
    static_configs:
      - targets: ["localhost:7072"]


sudo systemctl stop prometheus
sudo systemctl start prometheus

/grafana-server web

