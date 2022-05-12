# CICD
CICD is a set of practices that create a CICD pipeline, which allows us to have our latest version of the developed software to be integrated and deployed automatically to our production environment where customers use the software from, or to the customers directly.



## Continuous Integration
When a new version has been committed on a version control platform, we are then tasked with integrating that latest version to our release location/branch. For us to securely and safely perform this task, tests have to be performed to ensure the software works as designed in the release environment. Continuous integration utilises software to automate the software testing process, and then merge the latest version with the release branch.

## Continuous Delivery
Following our CI scenario, continuous delivery is an extension of CI, such that we can deliver our latest, released version of our software to our customers automatically, maybe sometimes to a pre-production environment, and automatically ensures that the software runs as designed in the pre-production environment. which should be identical to the production environment.

## Continuous Deployment
Continuous Deployment takes our deployment task one step further to automatically make our lastest version of the tested software available in the production environment, such that the services become available to the end-users.

## Jenkins
It is a tool to implement the CICD pipeline. It automates the processes the developed software have to be gone through before production and the deployment to the pre-production/production environment.

### Benefits
Automation allows for faster time to market while minimising manual errors. For example, instead of manually putting the software through unittests, run it on VMs with different configurations, and deploy it onto the production environment, Jenkins provides the option to automates it all.

## SDLC using Jenkins
1. From Development
2. Commit
3. Build 
4. Test
5. Stage
6. Deploy
7. To Production

## Other tools for CICD
- TeamCity
- Bamboo
- GitLab
- CircleCI
