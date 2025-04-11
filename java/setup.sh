# Symlink the OpenJDK installation to the Java Virtual Machines directory so that it can be used by other applications.
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# JavaVirtualMachines is used to select the default version of Java (the version used when running Java applications via CLI),
# and it only recognizes Java installations that are managed by the application.