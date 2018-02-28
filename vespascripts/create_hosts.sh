for k in admin0 content0 content1 stateless0 stateless1; do
    echo "host $k ="
    host $k
    host $k | awk '{ printf "%s\t%s\n", $4,$1}' >> /etc/hosts
done