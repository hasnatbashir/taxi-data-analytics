output=$(terraform apply -auto-approve | grep "public_ip_address")
echo $output
parsed_value=$(echo $output | awk -F '= ' '{print $3}')
parsed_value="${parsed_value//\"/}"
echo $parsed_value
# WSL doesn't connect ssh in /mnt/c/ subdirectories thats why I'm changing the directory to user home.
cd ~
pwd
rm ~/.ssh/known_hosts
ls ~/.ssh
scp -i "$2" $1 ec2-user@$parsed_value:~/
ssh -i "$2" ec2-user@$parsed_value "bash /home/ec2-user/aws-partial-download.sh"