module Data exposing
    ( CommercialExperience
    , Date
    , Detail
    , Education
    , EndDate(..)
    , PrintLink
    , Project
    , Skill
    , commercialExperience
    , education
    , linksPrint
    , location
    , myName
    , photo
    , photoHome
    , skills
    )

import Color
import Components.Image exposing (Image)


myName : String
myName =
    "Viacheslav Kubyshko"


photo : Image
photo =
    { url = "/images/photo.jpg"
    , description = "Viacheslav Kubyshko"
    , placeholderColor = Color.black
    }


photoHome : Image
photoHome =
    { url = "/images/photo-home.jpg"
    , description = "Viacheslav Kubyshko"
    , placeholderColor = Color.black
    }


location : String
location =
    "Tsaghkadzor, Armenia"


type alias PrintLink =
    { url : String, printAs : String }


linksCommon : List PrintLink
linksCommon =
    [ { url = "mailto:viacheslav.kubyshko@gmail.com"
      , printAs = "viacheslav.kubyshko@gmail.com"
      }
    , { url = "https://t.me/FantasmaParastasie"
      , printAs = "t.me/FantasmaParastasie"
      }
    , { url = "https://www.linkedin.com/in/viacheslavkubyshko"
      , printAs = "linkedin.com/in/viacheslavkubyshko"
      }
    ]


linksPrint : List PrintLink
linksPrint =
    linksCommon


type alias Detail =
    { key : String, value : String }


type alias Skill =
    { icon : Maybe String
    , title : String
    , details : List Detail
    }


skills : List Skill
skills =
    [ { icon = Nothing
      , title = "Technical Expertise"
      , details =
            [ { key = "Project Management"
              , value = "Redmine, ClickUp, Trello"
              }
            , { key = "E-commerce"
              , value = "Amazon Seller Central"
              }
            , { key = "Graphic Design"
              , value = "Adobe Photoshop, Adobe Illustrator, Adobe Lightroom, Figma, Procreate, Clip Studio"
              }
            , { key = "Other"
              , value = "Microsoft Office (Word, Excel, PowerPoint), Google Docs, VSCode, ChatGPT"
              }
            ]
      }
    , { icon = Nothing
      , title = "Communication"
      , details =
            [ { key = "Responsibilities"
              , value = "Operations management, e-commerce administration, issue resolution, cross-functional communication, graphic design, editing, providing feedback, presenting, techical translation"
              }
            , { key = "Values"
              , value = "Collaboration, transparency, accountability, empathy"
              }
            ]
      }
    ]


type alias Date =
    { month : Int, year : Int }


type EndDate
    = EndedOn Date
    | Present


type alias CommercialExperience =
    { company : String
    , role : String
    , startDate : Date
    , endDate : EndDate
    , url : Maybe String
    , details : List Detail
    }


commercialExperience : List CommercialExperience
commercialExperience =
    [ { company = "Logistics and e-commerce business (NDA)"
      , role = "E-commerce Operations Manager"
      , startDate = Date 9 2016
      , endDate = EndedOn <| Date 12 2023
      , url = Nothing
      , details =
            [ { key = "Project"
              , value = "A logistics and e-commerce business specializing in managing product sourcing, fulfillment, and sales operations on Amazon. The company operated as both a reseller and a service provider, ensuring the seamless flow of goods from suppliers to customers. The company handled inventory management, product listing creation, and order dispatch through Amazon’s marketplace infrastructure. The company aimed to provide reliable, efficient fulfillment while adhering to marketplace compliance standards."
              }
            , { key = "Responsibilities"
              , value = "Logistics coordination, inventory control, e-commerce platform administration, maintaining internal product database, compliance, issue resolution, order management, cross-functional communication."
              }
            , { key = "Key achievements"
              , value = "Developed and maintained an Google Sheets database to track shipped items, improved shipment accuracy, streamlined operations with custom tools, increased team efficiency, optimized product listings."
              }
            , { key = "Results"
              , value = "Increased order accuracy through consistent product verification, improved operational efficiency, enhanced product visibility on amazon through high-quality listings, contributing to increased sales."
              }
            ]
      }
    ]


type alias Project =
    { title : String
    , url : Maybe String
    , description : String
    , tech : String
    }


type alias Education =
    { title : String
    , url : Maybe String
    , details : String
    }


education : List Education
education =
    [ { title = "Graphic design"
      , url = Nothing
      , details = "South-Russian Humanitarian Institute, 2015 – 2019"
      }
    , { title = "Fundamental computer science and information technology"
      , url = Nothing
      , details = "Institute of Mathematics, Mechanics and Computer Science of Southern Federal University, 2012 – 2014"
      }
    ]
