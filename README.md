# Technical Test for AND Digital
This project was created to support my application towards AND Digital and follows the Technical Test Brief issued to me Monday 14th September 2020.

## Table of Contents

1. [Brief]()
    + [Requirements](https://github.com/HavidDulsman/Workout/blob/developer/README.md#requirements)
2. [VPC, Subnets and AZs]()
3. [Security]()
4. [Load Balancing]()
5. [Autoscaling Groups]()
6. [Instances, Launch Configuration and Web Servers]()
7. [Other Noteworthy Additions]()

## Brief
As quoted from a email by a AND Digital Recruiter:
    
    " Tech Test
      Terraform a load balanced web front end in AWS, GCP or Azure.
      The solution should incorporate a number of elements
      There should be a minimum of 2 instances and they need to be able to scale across availability zones.
      Ideally the web page should be secure.
      The Vpc should be appropriately split into the required subnets.
      The hosts should be running Linux and the choice of web server is down to the individualThe use of modules would be a good step but the focus should be on        good terraform structure."
      
### Requirements
From further conversation, the brief is designed to be vague in order to see how i approache the task. Before I started, I compiled some resources and task i would need to complete:
* A **load balancer**
* A **auto scaling group** with a **minimum of 2 instances at once**, which are spread over more than 1 availabiliy zone
* A **'Secure' web page**. This has me thinking of utilising HTTPS or NGINX, a web server that can be used as a proxy AND Load balancer
* A VPC with various subnets
* Instances that run Linux
* A use of **modules **

## VPC, Subnets and AZs
The application is ran on a **isolated VPC** that can be deployed by simply changing the VPC region variable. I used eu-west-2 (london) for building a testing of th application. In order to meet the goals of this test, terraform also builds **2 additional subnets that are in seperate availability zones**, which again can be changed using the variables.

Finally, in order to allow internet access to my new VPC, a have made a internet gateaway accompanied by a route table and route table associations to allow it to fucntion just like the default VPC available on account creation.

![VPC](https://i.imgur.com/818Mksk.png)

## Security
Various measures where taken and considered for security measures. Firstly, **2 security groups** where made, 1 for the elastic load balancer and the other for the launch configuration data. Both of these resources utilise specific port access through port 80 and operate under the **HTTP protocol**. Some time was taken considering the inclusion of HTTPS, a protocol I have only recently become used to outside of terraform, but opted not to as I believe the benefits of my **NGINX web server** make up for its loss. More information on the web server will follow.

![Security](https://i.imgur.com/XjwQOXY.png)

## Load Balancing
The load balancer, a big requirement for this project, **operates over the 2 subnets** created earlier and feature frequent health checks before deploying the launch configurations which again will be mentioned later. The Application will be accessible via the IP of the load balancer, a value that is produced at the very end of the terraform apply phase, allowing users to quickly access the application on completition.

![LB1](https://i.imgur.com/Mk2BkYw.png)

![LB2](https://i.imgur.com/4NVqaFZ.png)
## Autoscaling Groups
The autoscaling group again works over the two subnets, which are in seperate AZs. **The mininum size is set to 2**, with the desired also at 2 to show how a single instance is made in each subnet. This has been tested up to 7 instances and does work as intented!. The ASG utilises the load balancer for health checks.

A big addition is the use of the **launch configuration**, which tailor the new instances to the demands of the application, and install any dependancies the instance needs to operate efficiently.

![ASG1](https://i.imgur.com/yxg41Wk.png)
![ASG2](https://i.imgur.com/mUBNif4.png)

## Instances, Launch Configuration and Web Servers
The instances, of which are created by the autoscaling group are made to design thanks to my launch configuration resource. I have kept the application very **lightweight as to avoid any unwanted costs**, so have opted for a t2.micro and good ol' Ubuntu 18.04 for the basis of my instance. The launch configuration also features bash terminal commands, allowing me to install any other dependencies the instance made need to work in the auto scaling group. 

    "#!/bin/bash
    sudo apt-get update
    sudo apt-get -y install nginx 
    service nginx start"

These commands updates and download any new packages needed, installs the nginx linux client (and bypasses a input with -y) and runs the nginx service. As proof of the web server running, I have opted to leave the Nginx welcome page as the web page for the application.

![Instances](https://i.imgur.com/LLjQU1B.png)
![Web Page](https://i.imgur.com/3HPu1jQ.png)


## Other Noteworthy Additions
These minor mentions are either mentions of good practice, structure or little additions ive made to my application:
* The use of modules for each main cloud resource allow readers to quickly find the resoruce they want
* I have tried to hide as much 'sensitive' information as i can, by either directly referencing the id of new resources or hiding confidential information in hidden files.
* Utilisation of Git push and pull requests to keep an eye on version control

