module Pages.Cv exposing (Model, Msg, page)

import Color
import Components.Image as Image
import Data exposing (CommercialExperience, Date, Detail, Education, EndDate(..), Skill)
import Effect
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import ExtraColor
import GridLayout2 exposing (..)
import InlineStyle
import Layouts
import Page exposing (Page)
import Route exposing (Route)
import Shared
import TextStyle
import Typography exposing (preparedText)
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    ()


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = always ( (), Effect.none )
        , update = \_ _ -> ( (), Effect.none )
        , subscriptions = always Sub.none
        , view = always <| view shared
        }
        |> Page.withLayout (always <| Layouts.WebappLayout {})


view : Shared.Model -> View msg
view { layout } =
    { title = Data.myName
    , attributes = []
    , element =
        viewDesktop layout
    }


viewDesktop : LayoutState -> Element msg
viewDesktop layout =
    let
        showLink : { url : String, printAs : String } -> Element msg
        showLink { url, printAs } =
            newTabLink [ ExtraColor.fontColor Color.blue ] { label = preparedText printAs, url = url }

        boldText : String -> Element msg
        boldText =
            el [ Font.bold ] << text
    in
    column [ spacing 60, width fill ]
        [ gridRow layout
            [ gridColumn layout
                { widthSteps = 3 }
                [ spacing layout.grid.gutter ]
                [ Image.view layout
                    { widthSteps = 3, heightSteps = 3 }
                    [ Border.rounded 1000, clip ]
                    Data.photo
                ]
            , gridColumn layout
                { widthSteps = 1 }
                [ spacing layout.grid.gutter ]
                []
            , gridColumn layout
                { widthSteps = 8 }
                [ centerY, spacing 32 ]
                [ column [ spacing 16 ]
                    [ paragraph TextStyle.headline.attrs [ text Data.myName ]
                    , paragraph TextStyle.lead.attrs [ text "E-commerce Operations Manager, Graphic Designer" ]
                    ]
                , column (spacing 10 :: TextStyle.lead2.attrs)
                    [ paragraph []
                        [ boldText "7"
                        , text " years of e-commerce experience"
                        ]
                    ]
                ]
            ]
        , gridRow layout
            [ gridColumn layout
                { widthSteps = 4 }
                [ spacing layout.grid.gutter ]
                [ viewSidebarSection "Contacts" <|
                    (paragraph [ width fill ]
                        [ preparedText Data.location ]
                        :: List.map showLink Data.linksPrint
                    )
                , viewSidebarSection
                    "Specializations"
                    [ text "Operations management"
                    , text "E-commerce administration"
                    , text "Issue resolution"
                    , text "Graphic Design"
                    ]
                , viewSidebarSection "Languages" [ text "English (C1)", text "Russian (native)" ]
                ]
            , gridColumn layout
                { widthSteps = 8 }
                [ spacing layout.grid.gutter ]
                [ viewSection layout "Skills" <| List.map (viewSkillSet layout) Data.skills
                ]
            ]
        , viewSection layout "Experience" (List.map (viewCommercialExperience layout) Data.commercialExperience)
        , viewSection layout "Education" (List.map viewEducation Data.education)

        -- , viewSection layout "Open Source Contributions" (List.map viewProject Data.contributions ++ [ viewGitHubLink ])
        , viewTelegramLink
        ]


viewTelegramLink : Element msg
viewTelegramLink =
    paragraph []
        [ text "Let's have a chat on Telegram "
        , newTabLink []
            { label = el [ ExtraColor.fontColor Color.blue ] (text "@FantasmaParastasie")
            , url = "https://t.me/FantasmaParastasie/"
            }
        , text "!"
        ]


viewSkillSet : LayoutState -> Skill -> Element msg
viewSkillSet layout x =
    column [ width fill, spacing 20 ]
        [ paragraph (width fill :: TextStyle.header2.attrs) [ preparedText x.title ]
        , column [ width fill, spacing 16 ] <| List.map (viewDetail layout 2) x.details
        ]


viewCommercialExperience : LayoutState -> CommercialExperience -> Element msg
viewCommercialExperience layout x =
    column [ width fill, spacing 16, InlineStyle.render [ ( "break-inside", "avoid" ) ] ]
        [ column [ width fill, spacing 10 ]
            [ paragraph TextStyle.header2.attrs [ preparedText x.role ]
            , gridRow layout
                [ gridColumn layout
                    { widthSteps = 4 }
                    []
                    [ titleWithOptionalLink
                        { url = x.url
                        , label = paragraph TextStyle.lead.attrs [ preparedText x.company ]
                        }
                    ]
                , gridColumn
                    layout
                    { widthSteps = 8 }
                    [ alignRight, width fill ]
                    [ paragraph [ Font.color Color.detail ]
                        [ preparedText (showDate x.startDate ++ " — " ++ showEndDate x.endDate) ]
                    ]
                ]
            ]

        -- , column [ width fill, spacing 10 ] <| List.map (\line -> paragraph [] [ preparedText line ]) x.roleDescription
        , column [ width fill, spacing 16 ] <| List.map (viewDetail layout 4) x.details
        ]


viewEducation : Education -> Element msg
viewEducation x =
    column [ spacing 10, InlineStyle.render [ ( "break-inside", "avoid" ) ] ]
        [ titleWithOptionalLink
            { url = x.url
            , label = paragraph TextStyle.header2.attrs [ preparedText x.title ]
            }
        , paragraph [ Font.color Color.detail ] [ preparedText x.details ]
        ]



-- Reusable helpers
-- , column [ width fill, spacing 10 ] <| List.map (\line -> paragraph [] [ preparedText line ]) x.roleDescription


viewDetail : LayoutState -> Int -> Detail -> Element msg
viewDetail layout widthSteps x =
    gridRow layout
        [ paragraph (alignTop :: Font.color Color.detail :: widthOfGridSteps layout widthSteps) [ preparedText x.key ]
        , paragraph [ alignTop, width fill ] [ preparedText <| x.value ]
        ]


{-| Works as long as mobile and desktop have the same text styles.
If they become different, the whole helper better be removed.
-}
viewSection : LayoutState -> String -> List (Element msg) -> Element msg
viewSection layout title elements =
    case elements of
        h :: t ->
            column [ spacing layout.grid.gutter ]
                [ column
                    [ spacing layout.grid.gutter
                    , InlineStyle.render [ ( "break-inside", "avoid" ) ]
                    ]
                    [ paragraph TextStyle.header.attrs [ preparedText title ], h ]
                , column [ spacing layout.grid.gutter ] t
                ]

        _ ->
            Element.none


{-| Works as long as mobile and desktop have the same text styles.
If they become different, the whole helper better be removed.
-}
viewSidebarSection : String -> List (Element msg) -> Element msg
viewSidebarSection title elements =
    case elements of
        h :: t ->
            column [ spacing 16 ]
                [ column
                    [ spacing 16
                    , InlineStyle.render [ ( "break-inside", "avoid" ) ]
                    ]
                    [ paragraph TextStyle.header2.attrs [ preparedText title ], h ]
                , column [ spacing 16 ] t
                ]

        _ ->
            Element.none


showDate : Date -> String
showDate d =
    (String.padLeft 2 '0' <| String.fromInt d.month)
        ++ "/"
        ++ (String.padLeft 4 '0' <| String.fromInt d.year)


showEndDate : EndDate -> String
showEndDate ed =
    case ed of
        EndedOn d ->
            showDate d

        Present ->
            "present"


titleWithOptionalLink : { url : Maybe String, label : Element msg } -> Element msg
titleWithOptionalLink { url, label } =
    case url of
        Just urlString ->
            newTabLink [ ExtraColor.fontColor Color.blue ] { label = label, url = urlString }

        Nothing ->
            label
