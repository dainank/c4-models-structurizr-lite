workspace {

    model {
        student_user = person "Student User" {
            description "A student customer of the service."
            tags "User"
        }
        teacher_user = person "Teacher User" {
            description "A teacher customer of the service."
            tags "User"
        }
        softwareSystem = softwareSystem "Knowledge Navigator (KN) System" {
            webApplication = container "Web Application"
            apiGatewayLayer = container "API Gateway Layer"
            database = container "Database"
            description "Allows users to view, manage and use KN questions."
            tags "Tag 1"
        }

        # email_system = person "E-Mail System" {
        #     description "The internal (from school) Microsoft Exchange E-Mail System"
        # }

        student_user -> webApplication "View and answer KN questions"
        teacher_user -> webApplication "Manage the KN questions and view student's stats"
        webApplication -> database "Uses"
    }

    views {
        systemContext softwareSystem "Diagram1" {
            include *
            autoLayout
        }

        styles {
            element "Tag 1" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
            element "User" {
                background darkBlue
                color #ffffff
                shape Person
            }
        }
    }

}