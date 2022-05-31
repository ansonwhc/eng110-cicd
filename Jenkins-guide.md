# Jenkins Guide
This guide will go through steps shown in this diagram.
![](images/Jenkins_2.png)

- Keys generation guide [here](#keys-generation)
    - Set SSH keys on GitHub guide [here](#set-ssh-keys-on-github)
- Setting new job on Jenkins guide [here](#setting-new-job)
- CICD Pipeline Architecture guide [here](#cicd-pipeline-architecture)
- Jenkins server setup guide [here](#create-jenkins-server)

## Keys generation
We will generate a key pair used for connecting our local machine to GitHub and connecting to Jenkins from GitHub.  

1. We change directory to where we want the keys to be generated, e.g. `cd ~/.ssh`

2. Generate keys on windows by inputting the command `ssh-keygen -t rsa -b 4096 -C "<email address used for github>"`

### Set SSH keys on GitHub
This key is a public key for GitHub to identify the user that is accessing GitHub.  

1. We first navigate to our profile settings  
![image](https://user-images.githubusercontent.com/94448528/168164954-ab360888-ab5d-4bcb-8b0f-20c265b908cd.png)

2. Under Access, select SSH and GPG keys  
![image (1)](https://user-images.githubusercontent.com/94448528/168164988-de79bfea-73b4-473f-aecc-54e3e5c72be3.png)

3. Add new SSH key (this is the public key (.pub) we generated in [keys-generation](#keys-generation))

Official documentation available here: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent  

## Setting new job
<img src="https://user-images.githubusercontent.com/94448528/168165192-bba17a87-4877-4b29-951b-964ae1f62159.png" width="250">
<img src="https://user-images.githubusercontent.com/94448528/168165250-31950abf-9e0c-42b8-af9f-0cf96d8c7780.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168165255-b949ad54-fb5e-4823-9191-7c4bd4af05a7.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168165913-ce55f019-583e-4b2b-a96d-3a8a65196410.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168165851-60627ce0-fb59-4872-80e0-6b7b6c4c8a65.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166022-317a799b-978e-40bb-97d2-4d5d8fe18e37.png" width="750">

## Continuous Integration guide
<img src="https://user-images.githubusercontent.com/94448528/168166112-acc94c41-c536-47fe-a0a0-135ac0ce40d5.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166201-4145ecd1-bb1c-4723-9120-902ac50924de.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166587-06c75c69-2782-49a9-8317-743056fdf9f4.png" width="500">

![image (7)](https://user-images.githubusercontent.com/94448528/168167554-282660b3-fcc5-47aa-bb44-df83830fa1ca.png)

<img src="https://user-images.githubusercontent.com/94448528/168166605-dfba8f4c-6670-4006-be3a-dc9683c95a91.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166610-b6dbc7d0-f334-4f7d-8e27-cb4fd5f40246.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166617-9ede4fba-abde-45c5-9318-29b86e3c5f92.png" width="500">
<img src="https://user-images.githubusercontent.com/94448528/168166625-1f135d57-7a3a-487a-894a-c62eab9cb3b5.png" width="750">

![Screenshot 2022-05-12 215459](https://user-images.githubusercontent.com/94448528/168166631-4e46daaf-d760-4c17-a203-3208ae4a620f.png)

## CICD Pipeline Architecture
![Screenshot 2022-05-16 001427](https://user-images.githubusercontent.com/94448528/168498197-36ed37cf-ddff-4978-b9ed-046c97264630.png)

- When branch is changed, as shown  

<img src="https://user-images.githubusercontent.com/94448528/168498235-d4520bc4-fef0-4b6e-add6-5a9c90dc7b61.png" width="500">

- The job should be run on that branch only  

<img src="https://user-images.githubusercontent.com/94448528/168498268-bc258252-56e3-4c5e-acd5-8f4ba2edd591.png" width="500">

- Use Git Publisher to push the merge back to GitHub
    -  It requires the repo deploy key set to allow write access  
    
    <img src="https://user-images.githubusercontent.com/94448528/168498318-bb9d5dee-9c03-4b9c-b964-880603229ba5.png" width="500">

## Create Jenkins server

### First iteration
We will create one master/controller node (EC2 instance) and one agent node (EC2 instance)
- Assuming public and private key is already generated/configured/provided on AWS  

- Resources
    - Installing Jenkins on ubuntu 18.04: https://pkg.jenkins.io/debian-stable/
    - Jenkins on AWS: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#configure-jenkins
    - Jenkins reverse proxy with nginx: https://www.bogotobogo.com/DevOps/Jenkins/Jenkins_on_EC2_setting_up_master_slaves.php
    - Jenkins agent node on AWS: https://support.cloudbees.com/hc/en-us/articles/222978868-How-to-Connect-to-Remote-SSH-Agents-

1. Create Controller
    - create an EC2 instance on aws
    - allow port 22, 80, and 8080 from anywhere IPv4
    - SSH into the controller
    - update & upgrade
    - [ec2-controller ~]$ ```curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null```
    - [ec2-controller ~]$ ```echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] 
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee 
    /etc/apt/sources.list.d/jenkins.list > /dev/null```
    - [ec2-controller ~]$ `sudo apt-get update -y`
    - [ec2-controller ~]$ `sudo apt-get install fontconfig openjdk-11-jre -y`
    - [ec2-controller ~]$ `sudo apt-get install jenkins -y`
    - [ec2-controller ~]$ `sudo systemctl enable jenkins`
    - [ec2-controller ~]$ `sudo systemctl start jenkins`
    - [ec2-controller ~]$ `sudo systemctl status jenkins`
    - connect to `http://<your_server_public_DNS>:8080`

        ![](/images/unlock_jenkins.png)

    - [ec2-controller ~]$ `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
    - install suggested plugins/customise
    - create first admin user
    - on the left-hand side, click **Manage Jenkins**, and then click **Manage Plugins**
    - click on the **Available** tab, and then enter **Amazon EC2 plugin** at the top right
    - select the checkbox next to **Amazon EC2 plugin**, and then click **Install without restart**

        ![](/images/install_ec2_plugin.png)

    - once the installation is done, click Back to **Dashboard**
    - click on **Configure a cloud**

        ![](/images/configure_cloud.png)

    - click **Add a new cloud**, and select **Amazon EC2**. A collection of new fields appears
    - fill out all the fields (Note: You will have to Add Credentials of the kind AWS Credentials.)

2. Create Agent Node
    - create an EC2 instance on aws (used the same security group as the controller)
    - SSH into the controller
    - [ec2-agent ~]$ update & upgrade
    - [ec2-agent ~]$ `sudo apt-get install default-jre -y`
    - [local host] connect to `http://<your_server_public_DNS>:8080`
    - add New Node
    - remote root directory: `/home/ubuntu`
    
        ![](/images/Screenshot%202022-05-30%20182334.png)

    - Host: `<agent instance IP>`
    - choose key
        - if add new key
            - Kind: `SSH Username with private key`
            - Username: `ubuntu`
            - Private Key: `<enter directly>`
    - Host Key Verification Strategy: `Non verifying Verification Strategy`

3. When running jobs, specify to run on agent nodes

    ![](/images/Screenshot%202022-05-30%20182901.png)

