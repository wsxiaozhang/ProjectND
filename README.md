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
  5. $./build.sh 
  6. $./deploy.sh 8080:8080
  7. in browser, visit http://127.0.0.1:8080/welcome

* Project structure

