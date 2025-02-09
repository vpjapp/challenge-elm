module Data.Audience exposing
    ( AudienceType(..), Audience
    , audiencesDecoder, audiencesJSON
    )

{-| Data.Audiences module

This module implements everything related to audience resource.


# Interface

@docs AudienceType, Audience, audienceJSON

-}

import Data.DecodeUtil exposing (dataListDecoder)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)



-- Type definition


{-| Audience type
-}
type AudienceType
    = Authored
    | Shared
    | Curated


{-| Basic type of Audience record
-}
type alias Audience =
    { id : Int
    , name : String
    , type_ : AudienceType
    , folder : Maybe Int
    }



-- Decoders


audiencesDecoder : Decode.Decoder (List Audience)
audiencesDecoder =
    dataListDecoder audienceDecoder


audienceDecoder : Decode.Decoder Audience
audienceDecoder =
    Decode.succeed Audience
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "type" audienceTypeDecoder
        |> optional "folder" (Decode.maybe Decode.int) Nothing


audienceTypeDecoder : Decode.Decoder AudienceType
audienceTypeDecoder =
    Decode.string
        |> Decode.andThen
            (\typeValue ->
                case typeValue of
                    "curated" ->
                        Decode.succeed Curated

                    "user" ->
                        Decode.succeed Authored

                    "shared" ->
                        Decode.succeed Shared

                    type_ ->
                        -- I think this should never happen? At least not with the given data set
                        Decode.fail ("Unknown audience type" ++ type_)
            )



-- Fixtures


{-| Fixtures for audiences
In real world something like this is returned by `GET /api/audiences`

As you can see real world can be cruel sometimes.
JSON format is not exactly ideal (see shared, curated and type attr).

This is how we usually deal with making non-breaking continuous changes
from old version of API to new one.

You're free to use any strategy to decode JSON.

-}
audiencesJSON : String
audiencesJSON =
    """
    {
        "data": [
            {
                "id": 104,
                "name": "Food Lovers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_6"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 97,
                "name": "Brand Likers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q2157_8"
                            ],
                            "question": "q2157"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 116,
                "name": "Political Commentators",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_9"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 118,
                "name": "Music Lovers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_3"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 5028,
                "name": "Social Segments: Creators",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_1"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5030,
                "name": "Social Segments: Sharers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_2"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4996,
                "name": "Female 35-44",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_4"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5000,
                "name": "Male 16-24",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_2"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5006,
                "name": "Income: Mid 50%",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "i1_2"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 43311,
                "name": "Ad-Clickers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2157_4"
                            ],
                            "question": "q2157"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43312,
                "name": "Apple Pay Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3158_1"
                            ],
                            "question": "q3158"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 5003,
                "name": "Male 45-54",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_5"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5004,
                "name": "Male 55-64",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_6"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5007,
                "name": "Income: Top 25%",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "i1_3"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5013,
                "name": "Marital Status: In a Relationship",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q7_2"
                            ],
                            "question": "q7"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5010,
                "name": "Children in HH: 2",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_3"
                            ],
                            "question": "q8"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5016,
                "name": "Education: School Until 16",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q6_1"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5017,
                "name": "Education: School Until 18",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q6_2"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5018,
                "name": "Education: Trade/Technical School or College",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q6_3"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5022,
                "name": "Employment: Full-Time Parent",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_5"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5021,
                "name": "Employment: Full-Time Worker",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_1"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5023,
                "name": "Employment: Part-Time Worker",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_2"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5036,
                "name": "World Region: Middle East & Africa",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s6_5"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5025,
                "name": "Employment: Freelancer",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_3"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5026,
                "name": "Employment: Student",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_6"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 53516,
                "name": "Furniture Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q91_13"
                            ],
                            "question": "q91",
                            "suffixes": [
                                4
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 5029,
                "name": "Social Segments: Reviewers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_3"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5035,
                "name": "World Region: Latin America",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s6_3"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5031,
                "name": "Social Segments: Commenters",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_6"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5032,
                "name": "Social Segments: Passives",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_5"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4993,
                "name": "Female",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5019,
                "name": "Education: University",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q6_4"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4833,
                "name": "Meal Providers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q25_6"
                            ],
                            "question": "q25",
                            "not": true
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "r2021d_2"
                                    ],
                                    "question": "r2021d"
                                },
                                {
                                    "options": [
                                        "r2021e_2"
                                    ],
                                    "question": "r2021e"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q8_2",
                                "q8_3",
                                "q8_4"
                            ],
                            "question": "q8"
                        },
                        {
                            "and": [
                                {
                                    "options": [
                                        "r2021d_46"
                                    ],
                                    "question": "r2021d",
                                    "not": true
                                },
                                {
                                    "options": [
                                        "r2021e_46"
                                    ],
                                    "question": "r2021e",
                                    "not": true
                                }
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 5034,
                "name": "World Region: Europe",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s6_1"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4938,
                "name": "ITDM",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q16_8",
                                "q16_4",
                                "q16_3",
                                "q16_2"
                            ],
                            "question": "q16"
                        },
                        {
                            "options": [
                                "q17_4"
                            ],
                            "question": "q17"
                        },
                        {
                            "options": [
                                "q18a_4",
                                "q18a_5"
                            ],
                            "question": "q18a"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 5037,
                "name": "World Region: North America",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s6_2"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4995,
                "name": "Female 25-34",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4997,
                "name": "Female 45-54",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_5"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4998,
                "name": "Female 55-64",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_6"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5008,
                "name": "Children in HH: 0",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_1"
                            ],
                            "question": "q8"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5012,
                "name": "Marital Status: Single",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q7_1"
                            ],
                            "question": "q7"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5009,
                "name": "Children in HH: 1",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_2"
                            ],
                            "question": "q8"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5011,
                "name": "Children in HH: 3+",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_4"
                            ],
                            "question": "q8"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 4999,
                "name": "Male",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5001,
                "name": "Male 25-34",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5002,
                "name": "Male 35-44",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_4"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5014,
                "name": "Marital Status: Married",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q7_3"
                            ],
                            "question": "q7"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 32394,
                "name": "Social Networkers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r4154cd_1"
                            ],
                            "question": "r4154cd"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 5033,
                "name": "World Region: Asia Pacific",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s6_4"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 8306,
                "name": "Teens",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_16",
                                "q3_17",
                                "q3_18",
                                "q3_19"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 109,
                "name": "Parents (Young Children)",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q9_1",
                                "q9_2"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 8296,
                "name": "Console Gamers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q21510_6"
                            ],
                            "question": "q21510"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43303,
                "name": "Mobile Internet Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39a_3"
                            ],
                            "question": "q39a"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43307,
                "name": "Price Conscious Consumers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q20_58"
                            ],
                            "question": "q20",
                            "suffixes": [
                                4,
                                5
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32382,
                "name": "Tablet Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39a_6"
                            ],
                            "question": "q39a"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8304,
                "name": "Parents (Young Children)",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q9_1",
                                "q9_2"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 80901,
                "name": "blackberry",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126h_3"
                            ],
                            "question": "q126h"
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 32512,
                "name": "Business Leaders",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_1"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q16_1"
                            ],
                            "question": "q16"
                        },
                        {
                            "options": [
                                "q18a_5",
                                "q18a_4",
                                "q18a_3"
                            ],
                            "question": "q18a"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32514,
                "name": "Fashionistas",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q25_14"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32518,
                "name": "Social Segments: Commentators",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_6"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32521,
                "name": "Social Segments: Sharers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_2"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32519,
                "name": "Social Segments: Creators",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_1"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32520,
                "name": "Social Segments: Reviewers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_3"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32525,
                "name": "PC Gamers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q21510_1"
                            ],
                            "question": "q21510"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32526,
                "name": "Smartphone Owners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39d_1"
                            ],
                            "question": "q39d"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32522,
                "name": "Social Segments: Socializers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_4"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 32388,
                "name": "Second-Screeners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q120_4",
                                "q120_5",
                                "q120_3",
                                "q120_1",
                                "q120_2"
                            ],
                            "question": "q120"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32381,
                "name": "Spotify Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q320_5"
                            ],
                            "question": "q320",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32387,
                "name": "WeChat Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_26"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32377,
                "name": "Pinterest Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_4"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32361,
                "name": "Twitter Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_2"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32399,
                "name": "WhatsApp Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_29"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32384,
                "name": "Viber Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_41"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32350,
                "name": "F1 Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_17"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                3,
                                2,
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32385,
                "name": "YouTube Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_5"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32356,
                "name": "Shazam Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_25"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 85888,
                "name": "Premier League (Watch TV OR ONLINE) 55-64",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_6"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 32352,
                "name": "NFL Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_1"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                3,
                                2,
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32371,
                "name": "Facebook Messenger Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_23"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32699,
                "name": "Marital Status: Divorced/Widowed",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q7_4"
                            ],
                            "question": "q7"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 32372,
                "name": "Google+ Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_3"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32369,
                "name": "Sports Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q25_26"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32365,
                "name": "Vlog Watchers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r4154cd_34"
                            ],
                            "question": "r4154cd"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32380,
                "name": "SoundCloud Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q320_61"
                            ],
                            "question": "q320",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32358,
                "name": "Snapchat Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_30"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32404,
                "name": "Facebook Account Holders",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x1_1"
                            ],
                            "question": "q46x1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32373,
                "name": "iPhone Owners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q127ag2_5"
                            ],
                            "question": "q127ag2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32397,
                "name": "Online Shoppers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r4154cd_22"
                            ],
                            "question": "r4154cd"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32346,
                "name": "Brand Followers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q48_9",
                                "q48_10"
                            ],
                            "question": "q48"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32378,
                "name": "Reddit Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_48"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32405,
                "name": "Twitter Account Holders",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x1_2"
                            ],
                            "question": "q46x1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32376,
                "name": "LinkedIn Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_6"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32403,
                "name": "Podcast Listeners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r4154cd_30"
                            ],
                            "question": "r4154cd"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32396,
                "name": "Vine Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_56"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32697,
                "name": "Education: Post Graduate",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q6_5"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 32386,
                "name": "VPN Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q309_1"
                            ],
                            "question": "q309"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32085,
                "name": "4G Mobile Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39c_1"
                            ],
                            "question": "q39c"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32375,
                "name": "Netflix Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q320_1"
                            ],
                            "question": "q320",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32362,
                "name": "Facebook Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_1"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32348,
                "name": "Business Travelers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q311_1",
                                "q311_2"
                            ],
                            "question": "q311",
                            "suffixes": [
                                3
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32359,
                "name": "Students",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_6"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 35789,
                "name": "Ad-Blockers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q324_4"
                            ],
                            "question": "q324",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 35792,
                "name": "Social Sharers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2157_13"
                            ],
                            "question": "q2157"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 35793,
                "name": "Streaming Device Owners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39d_10"
                            ],
                            "question": "q39d"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 44991,
                "name": "Vacationers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q311_4",
                                "q311_3",
                                "q311_2",
                                "q311_1"
                            ],
                            "question": "q311",
                            "suffixes": [
                                2
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 45382,
                "name": "LINE Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_32"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 43304,
                "name": "Eco-Consumers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r2021e_48"
                            ],
                            "question": "r2021e"
                        },
                        {
                            "options": [
                                "q2154_11"
                            ],
                            "question": "q2154"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43308,
                "name": "Brand Experimenters",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q20_7"
                            ],
                            "question": "q20",
                            "suffixes": [
                                4,
                                5
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43306,
                "name": "Brand Conscious Consumers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q20_24"
                            ],
                            "question": "q20",
                            "suffixes": [
                                4,
                                5
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43309,
                "name": "Brand Loyalists",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q20_10"
                            ],
                            "question": "q20",
                            "suffixes": [
                                4,
                                5
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 95,
                "name": "Baby Boomers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_52",
                                "q3_53",
                                "q3_54",
                                "q3_55",
                                "q3_56",
                                "q3_57",
                                "q3_58",
                                "q3_59",
                                "q3_60",
                                "q3_61",
                                "q3_62",
                                "q3_63",
                                "q3_64"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 223,
                "name": "All Internet Uses",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2",
                                "q2_1"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 1809,
                "name": "Console Gamers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q21510_6"
                            ],
                            "question": "q21510"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 4994,
                "name": "Female 16-24",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_2"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 43305,
                "name": "Early Tech Adopters",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39d_1"
                            ],
                            "question": "q39d"
                        },
                        {
                            "options": [
                                "q39d_4"
                            ],
                            "question": "q39d"
                        },
                        {
                            "options": [
                                "q39d_5",
                                "q39d_6"
                            ],
                            "question": "q39d"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 60808,
                "name": "PRUK>Confident Connectors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s2_44"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q20_6",
                                "q20_8",
                                "q20_26",
                                "q20_16",
                                "q20_52",
                                "q20_42"
                            ],
                            "question": "q20",
                            "suffixes": [
                                5
                            ]
                        },
                        {
                            "options": [
                                "q4_3",
                                "q4_4"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q94new_23"
                            ],
                            "question": "q94new"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 48982,
                "name": "mums ( 21+) with kids aged 3-11) copy - pay TV",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_16",
                                "q3_17",
                                "q3_18",
                                "q3_19",
                                "q3_20"
                            ],
                            "question": "q3",
                            "not": true
                        },
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q8_2",
                                "q8_3",
                                "q8_4"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q9_2",
                                "q9_3"
                            ],
                            "question": "q9"
                        },
                        {
                            "options": [
                                "q1151_1"
                            ],
                            "question": "q1151"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 82636,
                "name": "NBC Chicago - C Suite",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "o0_0"
                            ],
                            "question": "gwiq-c0111.o0"
                        },
                        {
                            "options": [
                                "i1_2",
                                "i1_3"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 53506,
                "name": "Car Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q91_11"
                            ],
                            "question": "q91",
                            "suffixes": [
                                4
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 52334,
                "name": "Old Fiesta",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q14_1"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_3",
                                "q9_2",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9",
                            "not": true
                        },
                        {
                            "options": [
                                "q20_23",
                                "q20_16",
                                "q20_26",
                                "q20_11",
                                "q20_4"
                            ],
                            "question": "q20",
                            "min_count": "3",
                            "suffixes": [
                                5,
                                4
                            ]
                        },
                        {
                            "options": [
                                "q20_3",
                                "q20_42"
                            ],
                            "question": "q20",
                            "suffixes": [
                                5,
                                4
                            ]
                        },
                        {
                            "options": [
                                "q91_11"
                            ],
                            "question": "q91",
                            "suffixes": [
                                1,
                                2
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 52348,
                "name": "Mondeo",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_4"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q7_3"
                            ],
                            "question": "q7"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_3",
                                "q9_2",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q21a_17"
                                    ],
                                    "question": "q21a",
                                    "suffixes": [
                                        5,
                                        4
                                    ]
                                },
                                {
                                    "options": [
                                        "q20_14",
                                        "q20_8",
                                        "q20_16",
                                        "q20_3",
                                        "q20_23"
                                    ],
                                    "question": "q20",
                                    "min_count": "3",
                                    "suffixes": [
                                        5,
                                        4
                                    ]
                                }
                            ]
                        },
                        {
                            "options": [
                                "q91_11"
                            ],
                            "question": "q91",
                            "suffixes": [
                                1,
                                2
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 52377,
                "name": "Old Fiesta copy",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q14_1"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_3",
                                "q9_2",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9",
                            "not": true
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q20_23",
                                        "q20_16",
                                        "q20_26",
                                        "q20_11",
                                        "q20_4"
                                    ],
                                    "question": "q20",
                                    "min_count": "3",
                                    "suffixes": [
                                        5,
                                        4
                                    ]
                                },
                                {
                                    "options": [
                                        "q20_3",
                                        "q20_42"
                                    ],
                                    "question": "q20",
                                    "suffixes": [
                                        5,
                                        4
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 56010,
                "name": "AOL Travel for business abroad ",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q311_1"
                            ],
                            "question": "q311",
                            "suffixes": [
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_4",
                                "q4_5",
                                "q4_6"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "r52allse_1"
                            ],
                            "question": "r52allse"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 57550,
                "name": "Flipboard users  ",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_39"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 53514,
                "name": "Online-Only TV Viewers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q27lf_10"
                            ],
                            "question": "q27lf",
                            "not": true
                        },
                        {
                            "options": [
                                "q27lb_10"
                            ],
                            "question": "q27lb"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 53515,
                "name": "Linear Loyalists",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q27lf_10"
                            ],
                            "question": "q27lf"
                        },
                        {
                            "options": [
                                "q27lb_10"
                            ],
                            "question": "q27lb",
                            "not": true
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32360,
                "name": "Top 1%",
                "expression": {
                    "and": [
                        {
                            "or": [
                                {
                                    "options": [
                                        "q4dar_7"
                                    ],
                                    "question": "q4dar"
                                },
                                {
                                    "options": [
                                        "q4dau_7"
                                    ],
                                    "question": "q4dau"
                                },
                                {
                                    "options": [
                                        "q4dbe_7"
                                    ],
                                    "question": "q4dbe"
                                },
                                {
                                    "options": [
                                        "q4dbr_7"
                                    ],
                                    "question": "q4dbr"
                                },
                                {
                                    "options": [
                                        "q4dca_7"
                                    ],
                                    "question": "q4dca"
                                },
                                {
                                    "options": [
                                        "q4dfr_7"
                                    ],
                                    "question": "q4dfr"
                                },
                                {
                                    "options": [
                                        "q4dde_7"
                                    ],
                                    "question": "q4dde"
                                },
                                {
                                    "options": [
                                        "q4dhk_7"
                                    ],
                                    "question": "q4dhk"
                                },
                                {
                                    "options": [
                                        "q4din_7"
                                    ],
                                    "question": "q4din"
                                },
                                {
                                    "options": [
                                        "q4dind_7"
                                    ],
                                    "question": "q4dind"
                                },
                                {
                                    "options": [
                                        "q4dit_7"
                                    ],
                                    "question": "q4dit"
                                },
                                {
                                    "options": [
                                        "q4dire_7"
                                    ],
                                    "question": "q4dire"
                                },
                                {
                                    "options": [
                                        "q4djp_7"
                                    ],
                                    "question": "q4djp"
                                },
                                {
                                    "options": [
                                        "q4dml_7"
                                    ],
                                    "question": "q4dml"
                                },
                                {
                                    "options": [
                                        "q4dmx_7"
                                    ],
                                    "question": "q4dmx"
                                },
                                {
                                    "options": [
                                        "q4dnl_7"
                                    ],
                                    "question": "q4dnl"
                                },
                                {
                                    "options": [
                                        "q4dph_7"
                                    ],
                                    "question": "q4dph"
                                },
                                {
                                    "options": [
                                        "q4dpo_7"
                                    ],
                                    "question": "q4dpo"
                                },
                                {
                                    "options": [
                                        "q4dpt_7"
                                    ],
                                    "question": "q4dpt"
                                },
                                {
                                    "options": [
                                        "q4dru_7"
                                    ],
                                    "question": "q4dru"
                                },
                                {
                                    "options": [
                                        "q4dsa_7"
                                    ],
                                    "question": "q4dsa"
                                },
                                {
                                    "options": [
                                        "q4dsg_7"
                                    ],
                                    "question": "q4dsg"
                                },
                                {
                                    "options": [
                                        "q4dza_7"
                                    ],
                                    "question": "q4dza"
                                },
                                {
                                    "options": [
                                        "q4dsk_7"
                                    ],
                                    "question": "q4dsk"
                                },
                                {
                                    "options": [
                                        "q4des_7"
                                    ],
                                    "question": "q4des"
                                },
                                {
                                    "options": [
                                        "q4dse_7"
                                    ],
                                    "question": "q4dse"
                                },
                                {
                                    "options": [
                                        "q4dtw_7"
                                    ],
                                    "question": "q4dtw"
                                },
                                {
                                    "options": [
                                        "q4dth_7"
                                    ],
                                    "question": "q4dth"
                                },
                                {
                                    "options": [
                                        "q4dtr_7"
                                    ],
                                    "question": "q4dtr"
                                },
                                {
                                    "options": [
                                        "q4duae_7"
                                    ],
                                    "question": "q4duae"
                                },
                                {
                                    "options": [
                                        "q4duk_7"
                                    ],
                                    "question": "q4duk"
                                },
                                {
                                    "options": [
                                        "q4dus_7"
                                    ],
                                    "question": "q4dus"
                                },
                                {
                                    "options": [
                                        "q4dvt_7"
                                    ],
                                    "question": "q4dvt"
                                },
                                {
                                    "options": [
                                        "q4dcn_7"
                                    ],
                                    "question": "q4dcn"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q1d_2",
                                "q1d_4",
                                "q1d_3"
                            ],
                            "question": "q1d",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 82270,
                "name": "Mothers Gen Y",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_2",
                                "q8_4",
                                "q8_3"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q4_2",
                                "q4_3"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 105,
                "name": "Celebrity Gossipers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_13"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 120,
                "name": "Business Leaders",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_1"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q18a_4",
                                "q18a_5",
                                "q18a_3"
                            ],
                            "question": "q18a"
                        },
                        {
                            "options": [
                                "q16_1"
                            ],
                            "question": "q16"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 121,
                "name": "Travel Enthusiasts",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_5"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 122,
                "name": "Movie Buffs",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_4"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 123,
                "name": "Finance Experts",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_21"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 125,
                "name": "Social Segments: Passives",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r1_5"
                            ],
                            "question": "r1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 126,
                "name": "Smartphone Owners",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39d_1"
                            ],
                            "question": "q39d"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 129,
                "name": "Photo Fanatics",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_20"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 130,
                "name": "Parents",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 131,
                "name": "Culture Lovers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_15"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 5024,
                "name": "Employment: Self-Employed",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_4"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5027,
                "name": "Employment: Unemployed",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_7"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 5005,
                "name": "Income: Bottom 25%",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "i1_1"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Demographics",
                "folder": 357
            },
            {
                "id": 8305,
                "name": "Tech Influencers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q115_13"
                            ],
                            "question": "q115"
                        },
                        {
                            "options": [
                                "q20_6"
                            ],
                            "question": "q20",
                            "suffixes": [
                                5
                            ]
                        },
                        {
                            "options": [
                                "q25_1"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 43310,
                "name": "YouTube Visitors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r52all_9"
                            ],
                            "question": "r52all"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 32391,
                "name": "Skype Users",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126i_22"
                            ],
                            "question": "q126i"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Enterprise",
                "folder": 383
            },
            {
                "id": 8303,
                "name": "Parents",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 35788,
                "name": "Digital Content Purchasers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q85b1_17",
                                "q85b1_19",
                                "q85b1_18",
                                "q85b1_20",
                                "q85b1_16",
                                "q85b1_15",
                                "q85b1_11",
                                "q85b1_21",
                                "q85b1_13",
                                "q85b1_22",
                                "q85b1_9",
                                "q85b1_4",
                                "q85b1_12",
                                "q85b1_10",
                                "q85b1_8",
                                "q85b1_14",
                                "q85b1_6",
                                "q85b1_7",
                                "q85b1_3"
                            ],
                            "question": "q85b1"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 96,
                "name": "B2B Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q17_4",
                                "q17_5"
                            ],
                            "question": "q17"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 98,
                "name": "Dads",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 99,
                "name": "Entrepreneurs",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q14_4"
                            ],
                            "question": "q14"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 100,
                "name": "Fitness Fanatics",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_24"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 101,
                "name": "Petrol Heads",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_18"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 108,
                "name": "Moms",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 110,
                "name": "Environmentalists",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_8"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 111,
                "name": "Teens",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_16",
                                "q3_17",
                                "q3_18",
                                "q3_19"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": null,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 112,
                "name": "Brand Advocates",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q20_6"
                            ],
                            "question": "q20",
                            "suffixes": [
                                5
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 113,
                "name": "Gen X",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_33",
                                "q3_34",
                                "q3_35",
                                "q3_36",
                                "q3_37",
                                "q3_38",
                                "q3_39",
                                "q3_40",
                                "q3_41",
                                "q3_42",
                                "q3_43",
                                "q3_44",
                                "q3_45",
                                "q3_46",
                                "q3_47",
                                "q3_48",
                                "q3_49",
                                "q3_50",
                                "q3_51"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 8298,
                "name": "Gen X",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_33",
                                "q3_34",
                                "q3_35",
                                "q3_36",
                                "q3_37",
                                "q3_38",
                                "q3_39",
                                "q3_40",
                                "q3_41",
                                "q3_42",
                                "q3_43",
                                "q3_44",
                                "q3_45",
                                "q3_46",
                                "q3_47",
                                "q3_48",
                                "q3_49",
                                "q3_50",
                                "q3_51"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8299,
                "name": "Gen Y / Millennials",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_18",
                                "q3_19",
                                "q3_20",
                                "q3_21",
                                "q3_22",
                                "q3_23",
                                "q3_24",
                                "q3_25",
                                "q3_26",
                                "q3_27",
                                "q3_28",
                                "q3_29",
                                "q3_30",
                                "q3_31",
                                "q3_32"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 114,
                "name": "Gen Y / Millennials",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_18",
                                "q3_19",
                                "q3_20",
                                "q3_21",
                                "q3_22",
                                "q3_23",
                                "q3_24",
                                "q3_25",
                                "q3_26",
                                "q3_27",
                                "q3_28",
                                "q3_29",
                                "q3_30",
                                "q3_31",
                                "q3_32"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 127,
                "name": "Sports Players",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q25_25"
                            ],
                            "question": "q25"
                        },
                        {
                            "options": [
                                "q4141_2",
                                "q4141_16",
                                "q4141_9",
                                "q4141_3",
                                "q4141_18",
                                "q4141_7",
                                "q4141_15",
                                "q4141_10",
                                "q4141_11",
                                "q4141_1",
                                "q4141_5",
                                "q4141_8",
                                "q4141_14",
                                "q4141_6",
                                "q4141_19",
                                "q4141_17",
                                "q4141_13",
                                "q4141_4",
                                "q4141_12"
                            ],
                            "question": "q4141",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 128,
                "name": "Tech Influencers",
                "expression": {
                    "and": [
                        {
                            "and": [
                                {
                                    "options": [
                                        "q25_1"
                                    ],
                                    "question": "q25"
                                },
                                {
                                    "options": [
                                        "q115_13"
                                    ],
                                    "question": "q115"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q20_6"
                            ],
                            "question": "q20",
                            "suffixes": [
                                5,
                                4
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 133,
                "name": "Beauty Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q25_17"
                            ],
                            "question": "q25"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 1811,
                "name": "Mobile Gamers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q21510_4"
                            ],
                            "question": "q21510"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 358
            },
            {
                "id": 8293,
                "name": "Baby Boomers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q3_52",
                                "q3_53",
                                "q3_54",
                                "q3_55",
                                "q3_56",
                                "q3_57",
                                "q3_58",
                                "q3_59",
                                "q3_60",
                                "q3_61",
                                "q3_62",
                                "q3_63",
                                "q3_64"
                            ],
                            "question": "q3"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8294,
                "name": "Brand Advocates",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "r2021e_35"
                            ],
                            "question": "r2021e"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8297,
                "name": "Dads",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8300,
                "name": "Mobile Gamers",
                "expression": {
                    "or": [
                        {
                            "options": [
                                "q21510_4"
                            ],
                            "question": "q21510"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 8302,
                "name": "Moms",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q9_1",
                                "q9_2",
                                "q9_3",
                                "q9_4",
                                "q9_5",
                                "q9_6",
                                "q9_7"
                            ],
                            "question": "q9"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 77543,
                "name": "Hershey_SS_HomemadeTraditionalists",
                "expression": {
                    "and": [
                        {
                            "and": [
                                {
                                    "options": [
                                        "q9_5",
                                        "q9_6",
                                        "q9_7"
                                    ],
                                    "question": "q9"
                                },
                                {
                                    "options": [
                                        "q8_2",
                                        "q8_3"
                                    ],
                                    "question": "q8"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q4_5",
                                "q4_6"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q13newca_7",
                                "q13newca_8",
                                "q13newca_9",
                                "q13newca_6"
                            ],
                            "question": "q13newca"
                        },
                        {
                            "options": [
                                "q2_2",
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "s2_2"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q2021a_2",
                                "q2021a_4",
                                "q2021a_5",
                                "q2021a_25",
                                "q2021a_28",
                                "q2021a_38",
                                "q2021a_42",
                                "q2021a_46"
                            ],
                            "question": "q2021a",
                            "min_count": "4"
                        },
                        {
                            "options": [
                                "q94newfc_27"
                            ],
                            "question": "q94newfc"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 77538,
                "name": "Hershey_SS_ElvesUnderPressure",
                "expression": {
                    "and": [
                        {
                            "and": [
                                {
                                    "and": [
                                        {
                                            "options": [
                                                "q2_1"
                                            ],
                                            "question": "q2"
                                        },
                                        {
                                            "options": [
                                                "s2_2"
                                            ],
                                            "question": "s2"
                                        }
                                    ]
                                },
                                {
                                    "or": [
                                        {
                                            "options": [
                                                "q3_18",
                                                "q3_19",
                                                "q3_20",
                                                "q3_21",
                                                "q3_22",
                                                "q3_23",
                                                "q3_24",
                                                "q3_45",
                                                "q3_46",
                                                "q3_47",
                                                "q3_48"
                                            ],
                                            "question": "q3"
                                        },
                                        {
                                            "options": [
                                                "q4_3",
                                                "q4_4"
                                            ],
                                            "question": "q4"
                                        }
                                    ]
                                },
                                {
                                    "options": [
                                        "q13newca_7",
                                        "q13newca_6",
                                        "q13newca_8"
                                    ],
                                    "question": "q13newca"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q16_5",
                                "q16_6"
                            ],
                            "question": "q16"
                        },
                        {
                            "options": [
                                "q2021a_8",
                                "q2021a_39",
                                "q2021a_64",
                                "q2021a_65",
                                "q2021a_7"
                            ],
                            "question": "q2021a"
                        },
                        {
                            "options": [
                                "q94new_38",
                                "q94new_27"
                            ],
                            "question": "q94new"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 77539,
                "name": "Hershey_SS_GraciousGuests",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s2_2"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q13newca_7",
                                "q13newca_6",
                                "q13newca_8",
                                "q13newca_9"
                            ],
                            "question": "q13newca"
                        },
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q4_6"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q10_4",
                                "q10_1"
                            ],
                            "question": "q10"
                        },
                        {
                            "options": [
                                "q14_9",
                                "q14_1"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q2021a_2",
                                "q2021a_34",
                                "q2021a_41",
                                "q2021a_28"
                            ],
                            "question": "q2021a"
                        },
                        {
                            "options": [
                                "q94newfc_27"
                            ],
                            "question": "q94newfc"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 77541,
                "name": "Hershey_SS_LacklusterContributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1",
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q13newca_7",
                                "q13newca_8",
                                "q13newca_9",
                                "q13newca_6"
                            ],
                            "question": "q13newca"
                        },
                        {
                            "options": [
                                "q4_6",
                                "q4_5"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "s2_2"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q14_9",
                                "q14_8"
                            ],
                            "question": "q14"
                        },
                        {
                            "options": [
                                "q2021a_7",
                                "q2021a_28",
                                "q2021a_27",
                                "q2021a_34"
                            ],
                            "question": "q2021a"
                        },
                        {
                            "options": [
                                "q94newfc_27"
                            ],
                            "question": "q94newfc"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 77537,
                "name": "Hershey_SS_ChristmasEnthusiasts",
                "expression": {
                    "and": [
                        {
                            "or": [
                                {
                                    "options": [
                                        "q3_45",
                                        "q3_47",
                                        "q3_46",
                                        "q3_48"
                                    ],
                                    "question": "q3"
                                },
                                {
                                    "options": [
                                        "q4_3",
                                        "q4_4"
                                    ],
                                    "question": "q4"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q13newca_6",
                                "q13newca_7",
                                "q13newca_5"
                            ],
                            "question": "q13newca"
                        },
                        {
                            "options": [
                                "s2_2"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q8_3",
                                "q8_4",
                                "q8_2",
                                "q8_1"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q2021a_1",
                                "q2021a_45",
                                "q2021a_4"
                            ],
                            "question": "q2021a"
                        },
                        {
                            "options": [
                                "q94new_27"
                            ],
                            "question": "q94new"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 67512,
                "name": "Euro Viewers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_30"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 32363,
                "name": "Instagram Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_49"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 31642,
                "name": "ABC1",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s2_44"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q6_5",
                                "q6_4",
                                "q6_3"
                            ],
                            "question": "q6"
                        },
                        {
                            "options": [
                                "q15_1",
                                "q15_4",
                                "q15_6",
                                "q15_7",
                                "q15_10",
                                "q15_13",
                                "q15_16",
                                "q15_17",
                                "q15_19"
                            ],
                            "question": "q15"
                        },
                        {
                            "options": [
                                "i1_2",
                                "i1_3"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 32383,
                "name": "Tumblr Engagers/Contributors",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q46x2_9"
                            ],
                            "question": "q46x2"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 67513,
                "name": "Fashionistas",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q25_14"
                            ],
                            "question": "q25"
                        },
                        {
                            "options": [
                                "q94new_29"
                            ],
                            "question": "q94new"
                        },
                        {
                            "options": [
                                "q2021a_25"
                            ],
                            "question": "q2021a"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 31646,
                "name": "C2DE",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s2_44"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "i1_1"
                            ],
                            "question": "i1"
                        },
                        {
                            "options": [
                                "q15_9",
                                "q15_5",
                                "q15_8",
                                "q15_11",
                                "q15_12",
                                "q15_18",
                                "q15_2"
                            ],
                            "question": "q15"
                        },
                        {
                            "options": [
                                "q6_2",
                                "q6_1"
                            ],
                            "question": "q6"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 67511,
                "name": "Mobile Ad-Blockers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q324b_1"
                            ],
                            "question": "q324b"
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 67516,
                "name": "Olympics Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_3"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 36272,
                "name": "25-34 Urban Affluents",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q11_1"
                            ],
                            "question": "q11"
                        },
                        {
                            "options": [
                                "i1_3"
                            ],
                            "question": "i1"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 77536,
                "name": "Hershey_SS_CasualCelebrators",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "s2_2"
                            ],
                            "question": "s2"
                        },
                        {
                            "options": [
                                "q4_4",
                                "q4_5"
                            ],
                            "question": "q4"
                        },
                        {
                            "options": [
                                "q13newca_6",
                                "q13newca_7",
                                "q13newca_8"
                            ],
                            "question": "q13newca"
                        },
                        {
                            "options": [
                                "q2_2",
                                "q2_1"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q8_4",
                                "q8_3",
                                "q8_1",
                                "q8_2"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q2021a_2",
                                "q2021a_6",
                                "q2021a_41"
                            ],
                            "question": "q2021a"
                        },
                        {
                            "options": [
                                "q94new_27"
                            ],
                            "question": "q94new"
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 70335,
                "name": "ios + ford / chevrolet / Audi",
                "expression": {
                    "and": [
                        {
                            "or": [
                                {
                                    "options": [
                                        "q126h_1"
                                    ],
                                    "question": "q126h"
                                },
                                {
                                    "options": [
                                        "q126j_3"
                                    ],
                                    "question": "q126j"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q306a_14",
                                "q306a_5",
                                "q306a_8"
                            ],
                            "question": "q306a",
                            "suffixes": [
                                1,
                                2,
                                3,
                                4
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 80899,
                "name": "android",
                "expression": {
                    "and": []
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 85462,
                "name": "4G Mobile Users copy",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q39c_1"
                            ],
                            "question": "q39c"
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 32354,
                "name": "Premier League Fans",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                3,
                                2
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 84063,
                "name": "TV Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q91el_5"
                            ],
                            "question": "q91el",
                            "suffixes": [
                                4
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 84064,
                "name": "Vacationers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q311_1",
                                "q311_2",
                                "q311_3",
                                "q311_4"
                            ],
                            "question": "q311",
                            "suffixes": [
                                2
                            ]
                        }
                    ]
                },
                "curated": true,
                "type": "curated",
                "shared": false,
                "category": "Audiences",
                "folder": 383
            },
            {
                "id": 76232,
                "name": "Tesla Campaign - UK tech or ecofriendly Parents and expecting with high income ",
                "expression": {
                    "and": [
                        {
                            "or": [
                                {
                                    "options": [
                                        "q8_2",
                                        "q8_3",
                                        "q8_4"
                                    ],
                                    "question": "q8"
                                },
                                {
                                    "options": [
                                        "q31512_1"
                                    ],
                                    "question": "q31512"
                                }
                            ]
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q13newuk_13",
                                        "q13newuk_14"
                                    ],
                                    "question": "q13newuk"
                                },
                                {
                                    "options": [
                                        "i1_3"
                                    ],
                                    "question": "i1"
                                }
                            ]
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "r2021e_3"
                                    ],
                                    "question": "r2021e"
                                },
                                {
                                    "options": [
                                        "q2021a_48"
                                    ],
                                    "question": "q2021a"
                                }
                            ]
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "r2021e_38"
                                    ],
                                    "question": "r2021e"
                                },
                                {
                                    "options": [
                                        "r2021e_46"
                                    ],
                                    "question": "r2021e"
                                }
                            ]
                        },
                        {
                            "options": [
                                "r8_1"
                            ],
                            "question": "r8"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 30256,
                "name": "16-24 travellers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4_2"
                            ],
                            "question": "q4"
                        },
                        {
                            "and": [
                                {
                                    "options": [
                                        "q2_1"
                                    ],
                                    "question": "q2"
                                },
                                {
                                    "or": [
                                        {
                                            "options": [
                                                "q126a2co_968",
                                                "q126a2co_1023",
                                                "q126a2co_982"
                                            ],
                                            "question": "q126a2co"
                                        },
                                        {
                                            "options": [
                                                "q311_3",
                                                "q311_2",
                                                "q311_1"
                                            ],
                                            "question": "q311",
                                            "suffixes": [
                                                1,
                                                2,
                                                3
                                            ],
                                            "not": true
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 80898,
                "name": "tripomatic users maybe",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126h_2",
                                "q126h_1",
                                "q126h_3"
                            ],
                            "question": "q126h"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q94newtr_31"
                                    ],
                                    "question": "q94newtr"
                                },
                                {
                                    "options": [
                                        "q126d2_7"
                                    ],
                                    "question": "q126d2"
                                },
                                {
                                    "options": [
                                        "q4154m_16"
                                    ],
                                    "question": "q4154m"
                                },
                                {
                                    "options": [
                                        "q91tr_15",
                                        "q91tr_14"
                                    ],
                                    "question": "q91tr",
                                    "suffixes": [
                                        1,
                                        2,
                                        3,
                                        4
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 80900,
                "name": "ios",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q126h_1"
                            ],
                            "question": "q126h"
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 85882,
                "name": "Premier League (Watch TV OR ONLINE) Female",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 76588,
                "name": "Top 1% copy",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4dar_7"
                            ],
                            "question": "q4dar"
                        },
                        {
                            "options": [
                                "q4dau_7"
                            ],
                            "question": "q4dau"
                        },
                        {
                            "options": [
                                "q1d_2",
                                "q1d_4",
                                "q1d_3"
                            ],
                            "question": "q1d",
                            "suffixes": [
                                1
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 85884,
                "name": "Premier League (Watch TV OR ONLINE) 25-34",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_3"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85893,
                "name": "Premier League (Watch TV OR ONLINE) B2B IT Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q17_4"
                            ],
                            "question": "q17"
                        },
                        {
                            "options": [
                                "q18_1",
                                "q18_2"
                            ],
                            "question": "q18"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 91107,
                "name": "filter",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_1",
                                "q2_2"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 83677,
                "name": "Snapchat users (training) and travel",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "r52alls_1006"
                            ],
                            "question": "r52alls"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q25_5"
                                    ],
                                    "question": "q25"
                                },
                                {
                                    "options": [
                                        "q311_1",
                                        "q311_2",
                                        "q311_3",
                                        "q311_4"
                                    ],
                                    "question": "q311",
                                    "suffixes": [
                                        2,
                                        1
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85885,
                "name": "Premier League (Watch TV OR ONLINE) 35-44",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_4"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85883,
                "name": "Premier League (Watch TV OR ONLINE) 16-24",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_2"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85880,
                "name": "Premier League (Watch TV OR ONLINE) Male",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q2_1"
                            ],
                            "question": "q2"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 81598,
                "name": "APAC Social networking Mums with children ages 0-11 ",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "options": [
                                "q8_2",
                                "q8_4",
                                "q8_3"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q9_3",
                                "q9_2",
                                "q9_1"
                            ],
                            "question": "q9"
                        },
                        {
                            "options": [
                                "q27lj_1"
                            ],
                            "question": "q27lj"
                        },
                        {
                            "options": [
                                "s2_86",
                                "s2_852",
                                "s2_65",
                                "s2_886",
                                "s2_66",
                                "s2_82"
                            ],
                            "question": "s2"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85887,
                "name": "Premier League (Watch TV OR ONLINE) 45-54",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q4_5"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 82272,
                "name": "Mothers Gen X",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_2",
                                "q8_4",
                                "q8_3"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q4_4",
                                "q4_5",
                                "q4_6"
                            ],
                            "question": "q4"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 83800,
                "name": "Millennials Mums",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2_2"
                            ],
                            "question": "q2"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q3_35"
                                    ],
                                    "question": "q3"
                                },
                                {
                                    "options": [
                                        "q4_3"
                                    ],
                                    "question": "q4"
                                }
                            ]
                        },
                        {
                            "options": [
                                "q11_1"
                            ],
                            "question": "q11"
                        },
                        {
                            "options": [
                                "q6_4"
                            ],
                            "question": "q6"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q31512_1"
                                    ],
                                    "question": "q31512"
                                },
                                {
                                    "options": [
                                        "q8_2",
                                        "q8_3",
                                        "q8_4"
                                    ],
                                    "question": "q8"
                                }
                            ]
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 85890,
                "name": "Premier League (Watch TV OR ONLINE) B2B Buyers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q4142_6"
                            ],
                            "question": "q4142",
                            "suffixes": [
                                2,
                                3
                            ]
                        },
                        {
                            "options": [
                                "q17_5",
                                "q17_4"
                            ],
                            "question": "q17"
                        },
                        {
                            "options": [
                                "q18_1",
                                "q18_2"
                            ],
                            "question": "q18"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 89182,
                "name": "Facebook Vlogger Fans (APAC)",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q48_13"
                            ],
                            "question": "q48"
                        },
                        {
                            "options": [
                                "q46x2_1"
                            ],
                            "question": "q46x2"
                        },
                        {
                            "options": [
                                "s6_4"
                            ],
                            "question": "s6"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 89214,
                "name": "All things hair",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q7_1",
                                "q7_2",
                                "q7_3",
                                "q7_4"
                            ],
                            "question": "gwi-160815.q7"
                        }
                    ]
                },
                "curated": null,
                "type": "user",
                "shared": false,
                "category": null,
                "folder": null
            },
            {
                "id": 88145,
                "name": "High achiever",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q2021a_5",
                                "q2021a_8",
                                "q2021a_16",
                                "q2021a_68",
                                "q2021a_53"
                            ],
                            "question": "q2021a"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 87906,
                "name": "Top 25% - business travel or interest",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "i1_3",
                                "i1_4"
                            ],
                            "question": "i1"
                        },
                        {
                            "or": [
                                {
                                    "options": [
                                        "q25_10",
                                        "q25_21",
                                        "q25_11",
                                        "q25_36"
                                    ],
                                    "question": "q25"
                                },
                                {
                                    "options": [
                                        "q311_2"
                                    ],
                                    "question": "q311",
                                    "suffixes": [
                                        3
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "curated": false,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            },
            {
                "id": 91958,
                "name": "Mothers Main Food Shoppers",
                "expression": {
                    "and": [
                        {
                            "options": [
                                "q8_2",
                                "q8_3",
                                "q8_4"
                            ],
                            "question": "q8"
                        },
                        {
                            "options": [
                                "q12b_1"
                            ],
                            "question": "q12b"
                        }
                    ]
                },
                "curated": null,
                "type": "shared",
                "shared": true,
                "category": null,
                "folder": null
            }
        ]
    }
    """
