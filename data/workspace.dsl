workspace "Knowledge Navigator" {

    model {
        customer = person "Personal KN Customer" "A customer of the Knowledge Navigator system, with personal accounts." "Customer"
        # customerStudent = person "A student customer of the service with a personal account." "Student Customer"
        # customerTeacher = person "A teacher customer of the service with an elevated privileges personal account." "Teacher Customer"

        enterprise "Knowledge Navigator" {
            itSupportStaff = person "Customer IT Service Staff" "Customer service staff within the school." "School IT Staff"

            mainframe = softwaresystem "Mainframe School System" "Stores all of the core information about students, teachers, the school itself, etc." "Existing System"
            email = softwaresystem "E-mail System" "The internal Microsoft Exchange e-mail system." "Existing System"

            internetKnowledgeNavigatorSystem = softwaresystem "Internet Knowledge Navigator System" "Allows customers to view information about their knowledge navigator, and view exercises." {
                singlePageApplication = container "Single-Page Application" "Provides all of the Knowledge Navigator functionality to customers via their web browser." "TypeScript and Vue 3" "Web Browser"
                mobileApp = container "Mobile App" "Provides a limited subset of the Internet Knowledge Navigator functionality to customers via their mobile device." "Flutter (TBD.)" "Mobile App"
                webApplication = container "Web Application" "Delivers the static content and the Internet Knowledge Navigator single page application." "Vue 3 and Nuxt.js"
                apiApplication = container "API Application" "Provides Internet Knowledge Navigator functionality via a JSON/HTTPS API." "Rust and Warp Framework" {
                    signinController = component "Sign In Controller" "Allows users to sign in to the Internet Knowledge Navigator System." "Warp Rest Controller"
                    accountsSummaryController = component "Accounts Summary Controller" "Provides customers with a summary of their Knowledge Navigator accounts." "Warp Rest Controller"
                    resetPasswordController = component "Reset Password Controller" "Allows users to reset their passwords with a single use URL." "Warp Rest Controller"
                    securityComponent = component "Security Component" "Provides functionality related to signing in, changing passwords, etc." "Warp Component"
                    mainframeSchoolSystemFacade = component "Mainframe School System Facade" "A facade onto the mainframe School system." "Warp Component"
                    emailComponent = component "E-mail Component" "Sends e-mails to users." "Warp Componenet"
                }
                database = container "Database" "Stores user registration information, hashed authentication credentials, access logs, etc." "TBD." "Database"
            }
        }

        # relationships between people and software systems
        customer -> internetKnowledgeNavigatorSystem "Views, manages and answers KN questions using"
        internetKnowledgeNavigatorSystem -> mainframe "Gets account information from"
        internetKnowledgeNavigatorSystem -> email "Sends e-mail using"
        email -> customer "Sends e-mails to"
        customer -> itSupportStaff "Asks questions to" "Telephone/In Person"
        itSupportStaff -> mainframe "Uses"

        # relationships to/from containers
        customer -> webApplication "Visits knowledgenavigator.com/organization/workspace using" "HTTPS"
        customer -> singlePageApplication "Views, manages and answers KN questions using"
        customer -> mobileApp "Views, manages and answers KN questions using"
        webApplication -> singlePageApplication "Delivers to the customer's web browser"

        # relationships to/from components
        singlePageApplication -> signinController "Makes API calls to" "JSON/HTTPS"
        singlePageApplication -> accountsSummaryController "Makes API calls to" "JSON/HTTPS"
        singlePageApplication -> resetPasswordController "Makes API calls to" "JSON/HTTPS"
        mobileApp -> signinController "Makes API calls to" "JSON/HTTPS"
        mobileApp -> accountsSummaryController "Makes API calls to" "JSON/HTTPS"
        mobileApp -> resetPasswordController "Makes API calls to" "JSON/HTTPS"
        signinController -> securityComponent "Uses"
        accountsSummaryController -> mainframeSchoolSystemFacade "Uses"
        resetPasswordController -> securityComponent "Uses"
        resetPasswordController -> emailComponent "Uses"
        securityComponent -> database "Reads from and writes to" "JDBC"
        mainframeSchoolSystemFacade -> mainframe "Makes API calls to" "XML/HTTPS"
        emailComponent -> email "Sends e-mail using"

        deploymentEnvironment "Development" {
            deploymentNode "Developer Laptop" "" "Microsoft Windows 11" {
                deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                    developerSinglePageApplicationInstance = containerInstance singlePageApplication
                }
                deploymentNode "Docker Container - Web Server" "" "Docker" {
                    deploymentNode "Apache Tomcat" "" "Apache Tomcat 8.x" {
                        developerWebApplicationInstance = containerInstance webApplication
                        developerApiApplicationInstance = containerInstance apiApplication
                    }
                }
                deploymentNode "Docker Container - Database Server" "" "Docker" {
                    deploymentNode "Database Server" "" "Oracle 12c" {
                        developerDatabaseInstance = containerInstance database
                    }
                }
            }
            deploymentNode "Knowledge Navigator" "" "Knowledge Navigator data center" "" {
                deploymentNode "knowledge-navigator-dev001" "" "" "" {
                    softwareSystemInstance mainframe
                }
            }

        }

        deploymentEnvironment "Live" {
            deploymentNode "Customer's mobile device" "" "Apple iOS or Android" {
                liveMobileAppInstance = containerInstance mobileApp
            }
            deploymentNode "Customer's computer" "" "Microsoft Windows or Apple macOS" {
                deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                    liveSinglePageApplicationInstance = containerInstance singlePageApplication
                }
            }

            deploymentNode "Knowledge Navigator" "" "Knowledge Navigator data center" {
                deploymentNode "knowledge-navigator-web***" "" "Ubuntu 20.04 LTS" "" 4 {
                    deploymentNode "Apache Tomcat" "" "Apache Tomcat 8.x" {
                        liveWebApplicationInstance = containerInstance webApplication
                    }
                }
                deploymentNode "knowledge-navigator-api***" "" "Ubuntu 20.04 LTS" "" 8 {
                    deploymentNode "Apache Tomcat" "" "Apache Tomcat 8.x" {
                        liveApiApplicationInstance = containerInstance apiApplication
                    }
                }

                deploymentNode "knowledge-navigator-db01" "" "Ubuntu 20.04 LTS" {
                    primaryDatabaseServer = deploymentNode "Oracle - Primary" "" "Oracle 12c" {
                        livePrimaryDatabaseInstance = containerInstance database
                    }
                }
                deploymentNode "knowledge-navigator-db02" "" "Ubuntu 20.04 LTS" "Failover" {
                    secondaryDatabaseServer = deploymentNode "Oracle - Secondary" "" "Oracle 12c" "Failover" {
                        liveSecondaryDatabaseInstance = containerInstance database "Failover"
                    }
                }
                deploymentNode "knowledge-navigator-prod001" "" "" "" {
                    softwareSystemInstance mainframe
                }
            }

            primaryDatabaseServer -> secondaryDatabaseServer "Replicates data to"
        }
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext internetKnowledgeNavigatorSystem "SystemContext" {
            include *
            animation {
                internetKnowledgeNavigatorSystem
                customer
                mainframe
                email
            }
            autoLayout
        }

        container internetKnowledgeNavigatorSystem "Containers" {
            include *
            animation {
                customer mainframe email
                webApplication
                singlePageApplication
                mobileApp
                apiApplication
                database
            }
            autoLayout
        }

        component apiApplication "Components" {
            include *
            animation {
                singlePageApplication mobileApp database email mainframe
                signinController securityComponent
                accountsSummaryController mainframeSchoolSystemFacade
                resetPasswordController emailComponent
            }
            autoLayout
        }

        dynamic apiApplication "SignIn" "Summarises how the sign in feature works in the single-page application." {
            singlePageApplication -> signinController "Submits credentials to"
            signinController -> securityComponent "Validates credentials using"
            securityComponent -> database "select * from users where username = ?"
            database -> securityComponent "Returns user data to"
            securityComponent -> signinController "Returns true if the hashed password matches"
            signinController -> singlePageApplication "Sends back an authentication token to"
            autoLayout
        }

        deployment internetKnowledgeNavigatorSystem "Development" "DevelopmentDeployment" {
            include *
            animation {
                developerSinglePageApplicationInstance
                developerWebApplicationInstance developerApiApplicationInstance
                developerDatabaseInstance
            }
            autoLayout
        }

        deployment internetKnowledgeNavigatorSystem "Live" "LiveDeployment" {
            include *
            animation {
                liveSinglePageApplicationInstance
                liveMobileAppInstance
                liveWebApplicationInstance liveApiApplicationInstance
                livePrimaryDatabaseInstance
                liveSecondaryDatabaseInstance
            }
            autoLayout
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Customer" {
                background #08427b
            }
            element "School IT Staff" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Failover" {
                opacity 25
            }
        }
    }
}