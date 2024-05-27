workspace "GLFW"
    location "output/build"

    newaction {
        trigger = "clean",
        description = "delete generated build files and binaries",
        execute = function()
            os.rmdir("output")
            os.mkdir("output")
            os.mkdir("output/build")
            os.mkdir("output/lib")
            os.mkdir("output/lib-obj")
        end
    }

    staticruntime "On"
    systemversion "latest"

    targetdir   ("output/lib/"      .. "%{cfg.architecture}-%{cfg.system}-%{cfg.buildcfg}")
    objdir      ("output/lib-obj/"  .. "%{cfg.architecture}-%{cfg.system}-%{cfg.buildcfg}/%{prj.name}")

    configurations {
        "debug", "release"
    }

    platforms {
        "x86_64", "x86"
    }

    filter "platforms:x86_64"
        architecture "x86_64"

    filter "platforms:x86"
        architecture "x86"

    filter "configurations:debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:release"
        runtime "Release"
        optimize "Speed"

        defines {
            "NDEBUG"
        }

    filter {  }

    project "GLFW"
        kind "StaticLib"

        language "C"    --
        warnings "Off"  -- usally i like to use Extra but GLFW have alot of annoying warnings

        source = "src"
        header = "include/GLFW"

        files {
            "%{header}/glfw3.h",
            "%{header}/glfw3native.h",
            "%{source}/internal.h",
            "%{source}/platform.h",
            "%{source}/mappings.h",
            "%{source}/context.c",
            "%{source}/init.c",
            "%{source}/input.c",
            "%{source}/monitor.c",
            "%{source}/platform.c",
            "%{source}/vulkan.c",
            "%{source}/window.c",
            "%{source}/egl_context.c",
            "%{source}/osmesa_context.c",
            "%{source}/null_platform.h",
            "%{source}/null_joystick.h",
            "%{source}/null_init.c",
            "%{source}/null_monitor.c",
            "%{source}/null_window.c",
            "%{source}/null_joystick.c"
        }

        filter "system:linux"
            pic "On"

            files {
                "%{source}/x11_init.c",
                "%{source}/x11_monitor.c",
                "%{source}/x11_window.c",
                "%{source}/xkb_unicode.c",
                "%{source}/posix_poll.c",
                "%{source}/posix_time.c",
                "%{source}/posix_thread.c",
                "%{source}/posix_module.c",
                "%{source}/glx_context.c",
                "%{source}/egl_context.c",
                "%{source}/osmesa_context.c",
                "%{source}/linux_joystick.c"
            }

            defines {
                "_GLFW_X11"
            }

        filter "system:windows"
            -- buildoptions{
            --     "/MT"
            -- }

            files {
                "%{source}/win32_init.c",
                "%{source}/win32_module.c",
                "%{source}/win32_joystick.c",
                "%{source}/win32_monitor.c",
                "%{source}/win32_time.h",
                "%{source}/win32_time.c",
                "%{source}/win32_thread.h",
                "%{source}/win32_thread.c",
                "%{source}/win32_window.c",
                "%{source}/wgl_context.c",
                "%{source}/egl_context.c",
                "%{source}/osmesa_context.c"
            }

            defines { 
                "_GLFW_WIN32",
                "_CRT_SECURE_NO_WARNINGS"
            }