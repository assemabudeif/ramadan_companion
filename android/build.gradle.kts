allprojects {
    repositories {
        google()
        mavenCentral()
    }
    
    configurations.all {
        resolutionStrategy.eachDependency {
            if (project.name == "isar_flutter_libs") {
                if (requested.group == "androidx.core") {
                    useVersion("1.6.0")
                }
            } else {
                // For other projects, ensure they have high enough version for recent plugins
                if (requested.group == "androidx.core") {
                    if (requested.name == "core" || requested.name == "core-ktx") {
                        if (requested.version != null && requested.version!!.startsWith("1.6")) {
                             // Don't downgrade if it was already 1.7+
                        } else {
                             // Many plugins need 1.9.0+ now
                             // but let's just not force it globally if not needed,
                             // or force 1.12.0 for everything else.
                             useVersion("1.12.0") 
                        }
                    }
                }
            }
        }
    }

    // Try to set SDK as soon as plugin is applied
    plugins.withId("com.android.application") {
        extensions.configure<com.android.build.gradle.BaseExtension>("android") {
            try {
                compileSdkVersion(34)
                defaultConfig.targetSdk = 34
            } catch (e: Exception) {}
        }
    }
    plugins.withId("com.android.library") {
        extensions.configure<com.android.build.gradle.BaseExtension>("android") {
            try {
                compileSdkVersion(34)
                defaultConfig.targetSdk = 34
            } catch (e: Exception) {}
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.getByName("android")
            if (android is com.android.build.gradle.BaseExtension) {
                // Setup namespace for legacy plugins
                if (android.namespace == null) {
                    android.namespace = if (project.group.toString().isNotEmpty()) {
                        project.group.toString()
                    } else {
                        "dev.isar.${project.name.replace("-", "_")}"
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}