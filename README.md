ProjectND
=========

Sample project for testing dCloud


* Prerequisites
  
  1. docker >= v1.0 
  2. git client
  3. be able to access private docker image repository http://9.181.27.216:8080



* How to Run
  
  1. git clone https://github.com/wsxiaozhang/ProjectND.git
  2. $cd ./ProjectND
  3. update application under ./work_dir/welcome
      e.g. change codes in status.jsp
  4. go back to project root path /ProjectND
  5. $sudo ./build.sh 
  6. $sudo ./deploy.sh 8080:8080
  7. in browser, visit http://127.0.0.1:8080/welcome



* Project structure 
  (keep on changing)
  
  --ProjectND
      
      --base_image     // optional, Dockerfile of project base image. e.g., here is a base Java image
      --local_image    // Dockerfile of project build and test image
      --work_dir       // workspace of project src, dependencies (like .m2 repository), and scripts of build and test project
          --welcome    // project src
          --build_app  // scripts of how to biuld project
          --run_app    // scripts of how to run project for test
      --build.sh       // scripts of kick off build project by using docker image
      --deploy.sh      // scripts of kick off run project in docker image
