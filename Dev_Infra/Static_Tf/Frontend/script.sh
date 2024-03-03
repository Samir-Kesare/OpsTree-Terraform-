#!/bin/bash

# Modify package.json with the ALB DNS placeholder
sed -i 's/"homepage": "https:\/\/opstree.github.io",/"homepage": "http:\/\/{{ALB_DNS}}",/' /home/ubuntu/Frontend/package.json
sed -i '/"proxy": "http:\/\/localhost:3000"/d' /home/ubuntu/Frontend/package.json

# Start your application
cd /home/ubuntu/Frontend 
npm start


# Keep in mind that whenever you destroy, then instead of DNS, {{ALB_DNS}} is written like this: "http:\/\/{{ALB_DNS}}",/'
