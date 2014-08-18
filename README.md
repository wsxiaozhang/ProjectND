ProjectND
=========

Sample project for testing dCloud


* Prerequisites
  
  1. docker >= v1.0 
  2. git client
  3. be able to access private docker image repository http://9.181.27.216:8080



* How to Run

  * Local Dev and Test

    1. git clone https://github.com/wsxiaozhang/ProjectND.git
    2. $cd ./ProjectND
    3. update application under ./work_dir/welcome
      e.g. change codes in status.jsp
    4. go back to project root path /ProjectND
    5. $sudo ./build.sh 
    6. $sudo ./deploy.sh 8080:8080
    7. in browser, visit http://127.0.0.1:8080/welcome
  
  * Local Debug
  
    I. Debug Web application with Tomcat 7
      just following above 5 steps to get application build. 
      Note: in order to keep local test independent to debug, pls use bind different ports for application running. There has to be only one application instance binds to one specific port on the host OS.
      In this sample of debug, the application (welcome_servlet) listens to 8888 for web request, while it listens to 7778 for accepting debug packets.
      6. $sudo ./debug_web.sh
      7. in eclipse, edit "debug configuration" against the web application project. 
          New a remote debug configuration, by attaching to "localhost", "7778" and "dt_socket" stack.
          Apply those changes, and go on debug with this configuration.
          If the remote debug connection established successfully, then eclipse will prompt you to switch to "debug" perspective.
      8. in browser, visit http://127.0.0.1:8888/hello and click on the hyperlink to trigger a servlet action
      9. in eclipse, the debugger should run to the latest breakpoint in application code.
  
  * Publish app to cloud
    
    just following above 5 steps of "Local Dev and Test" to get application build
    6. $sudo ./publish.sh welcome welcome.de.bluemix.cdl.ibm.com
    7. after a while, in brower, visit http://welcome.de.bluemix.cdl.ibm.com 


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
