#  Docker kit for Oracle WebCenter Sites v12c

<h1>What is in this kit?</h1>

[](#ws1) This kit allows to install and manage webcenter sites using docker.

[](#ws2) It is a collection of scripts to build docker images in different environments.

- [](#ws4) You can build your image in a virtual machine in Virtualbox in your desktop machine.
- [](#ws5) Or, you can build your image in a virtual machine on demand on Amazon Web Services cloud.
- [](#ws6) Finally, you can build you image in any server running the Linux operating system.
- [](#ws7) 	Actually, many more options are available, since docker supports a large number of environments.

[](#ws8) 	Once built, the images can be saved on the Amazon S3 web storage service.

[](#ws9) Scripts are provided to reuse the images without having to rebuild them.

<h1>Using this kit</h1>

[](#uk1) Let's start with an overview of how to use this kit.

- [](#uk2) First step is to download both the docker toolbox, for using Docker, and the kit from GitHub.
- [](#uk3) Then, you can use it to build on Amazon EC2. The steps are the following.
- [](#uk4) The kit provides a script to create a proper virtual machine on Amazon EC2 for Sites 12c.
- [](#uk5) Using the virtual machine, you will use the scripts also to create a docker image with weblogic and webcenter sites.
- [](#uk6) The created image can be used immediately or stored on the Amazon S3 for reuse.

[](#uk7) You can then run the image you created in a server in your local network.

[](#uk8) The kit provides the script to run Docker in an existing _Linux server_.

[](#uk9) The kit include the scripts to download the image you created from _Amazon S3_.

[](#uk10)	Finally, you can run your image in _your server_.
