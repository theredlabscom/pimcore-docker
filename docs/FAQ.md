# Frequently Asked Questions

*Last Updated: 2019-10-25*

## What are the recommended system requirements?

* Linux or Mac OS operating system (Windows has issues with long paths)
* At least 16GB of RAM
* Quad Core Intel i5 3rd generation or equivalent Processor (or later)
* Solid State Drive with at least 30GB of free space, the more the merrier :)
* Latest version of Docker CE (Linux) or Docker Engine (Mac OS)

## How to set the correct permissions for my PIMcore instance?

If you followed any of the built-in installation scripts.  Permissions
should be fine out-of-the-box.

But, if you still need to fix webserver persmissions it's as easy as:

    docker exec pimcore-web chown -R www-data:www-data *

## My containers are running slow, what can I do?

Performance depends a lot on the features that you have on your CPU, the
processes you are running simultaneously, the amount of data stored in
PIMcore and a series of factors that go beyond the scope of this document.

Also, keep in mind that PIMcore is a software product that runs on top
of A LOT of third party dependencies and has many abstraction layers,
so... performance may not be it's strong point.

However, if you are experiencing bad performance try the following
before upgrading your hardware:

1. Make sure you meet the recommended system requirements
2. Stop any unnecessary processes on the host system
3. Reboot the host system, wait a few minutes and then run `docker-compose up -d`
4. Make sure the latest patches for your operating system have been installed
5. Check that the PIMcore maintenance script is running every 5 minutes on
the web container.
6. If you are working on a custom Extension/Plugin, check your code.
7. Monitor your containers using `docker stats` command,
 [cAdvisor](https://github.com/google/cadvisor) or any other docker monitoring tool.

If everything on this list fails, maybe you're experiencing other types
of issues or you'll need more powerful hardware... sorry, you're on your
own.

