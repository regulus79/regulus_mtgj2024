
regulus2024_dialogue.dialogue = {

    dni1 = {
        {
            text = function()
                local lines = {
                    "I'm busy.",
                    "I can't talk right now.",
                    "Don't talk to me.",
                    "Leave me alone.",
                }
                return lines[math.random(#lines)]
            end
        }
    },

    find_a_place_to_stay1 = {
        {
            text = "What do you want?",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "No, I don't take visitors.",
            responses = {library = "Where is the library?"}
        },
        {
            text = "Who knows? No one knows anything around here.",
        },
    },
    find_a_place_to_stay2 = {
        {
            text = "What is it? Be quick, I'm busy right now.",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "No, find someone else.",
            responses = {library = "Where is the library?"}
        },
        {
            text = "Never heard of it.",
        },
    },
    find_a_place_to_stay3 = {
        {
            text = "Hello there.",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "Stay for the night? Nay, I do not have space. Nor enough food to share.\nI heard the wizard down there is quite hospitable, maybe you should try him.",
            responses = {library = "Where is the library?"}
        },
        {
            text = "What's a library?",
        },
    },
    ask_wizard_for_place_to_stay = {
        {
            text = "What's going on, young one?",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "You know what, come on in.",
        },
    },
    talk_to_wizard_again = {
        {
            text = "Your bedroom is upstairs. Do you need anything?",
            responses = {library = "Where is the library?"},
        },
        {
            text = "The library? Who told you about it?\nNo, no, there is no library here. It's not here. It's not in here!",
            responses = {next = "next"},
        },
        {
            text = "Never mind now. You bedroom is upstairs, go check it out if you wish.",
        },
    },
    talk_to_wizard_in_library = {
        {
            text = "What are you doing here?",
            responses = {library = "I wanted to find the library."},
        },
        {
            text = "I should have known. When you asked about it—the library—I was shocked. \nNo one in this village knows what a library is. And for good reason.",
            responses = {next = "next"},
        },
        {
            text = "It is dangerous—to know.",
            responses = {next = "next"},
        },
        {
            text = "As you read more, and your mind is enlightened, they sense it. \nThey will find you when you are traveling alone, and they will attack you.",
            responses = {next = "next"},
        },
        {
            text = "It is the darkness. You cannot escape them, they are outside of space. \nThey know when you read. When understanding is flowing into your mind, they can feel it.",
            responses = {next = "next"},
        },
        {
            text = "I do not know why they do this. I do not want to risk knowing.",
            responses = {next = "next"},
        },
        {
            text = "But I theorize that if someone were to gain too much knowledge, they would \nknow how to banish the darkness forever.",
            responses = {next = "next"},
        },
        {
            text = "...",
            responses = {next = "next"},
        },
        {
            text = "I do not let anyone into this library.",
            responses = {next = "next"},
        },
        {
            text = "Look, I would gladly open it to everyone, to let knowledge spread to the \nends of the earth! But I do not want to be the cause of someone's death.",
            responses = {next = "next"},
        },
        {
            text = "There is too much information. \nOne could be killed after even spending a few hours reading.",
            responses = {next = "next"},
        },
        {
            text = "Even I do not know all the books in here. I cannot risk it.",
            responses = {next = "next"},
        },
        {
            text = "So I beg you, reconsider your actions before it is too late! Your studying is unwise.",
            responses = {study = "I must find a way to banish the darkness."},
        },
        {
            text = "You actually want to try? No, no! That is madness! \nThey will kill you before you get the chance to find all the right books and spells.",
            responses = {I_must_try = "I must try."},
        },
        {
            text = "Sigh...",
            responses = {next = "next"},
        },
        {
            text = "Let me tell you what I know.",
            responses = {next = "next"},
        },
        {
            text = "In order to banish the darkness, you must travel to the Pedestal of Banishment. \nThere you will find the clues.",
            responses = {next = "next"},
        },
        {
            text = function(player)
                player:get_inventory():add_item("main", "regulus2024_nodes:pedestal_finder") -- yeee this could go wrong if the inv is full but like.. hopefully it isn't?
                return "Here, I give you this staff which will guide you to the pedestal.\nFollow where the sparkles lead you."
            end,
            responses = {next = "next"},
        },
        {
            text = "Let your heart be filled with freedom. I wish you luck.",
        },
    }
    --[[
    -- OLD STUFF
    its_dangerous_outside_come_in = {
        {
            text = "What are you doing out here this late at night? It's dangerous out here, you should come inside."
        }
    },
    I_must_get_to_my_studies = {
        {
            text = "I must get to my studies"
        }
    },

    talking_to_villagers = {
        {
            text = function(player)
                local num_villagers_encountered = regulus2024_quests.get_active_quests(player)["talk_to_villagers"].num_villagers_encountered
                local lines = {
                    "Hi1",
                    "Hi2",
                    "Hi3",
                    "Hi4",
                }
                return lines[num_villagers_encountered + 1]
            end
        }
    },


    -- Test dialogue
    hello = {
        {
            text = "Oh hey there, stranger! What are you doing in these parts?",
            responses = {
                lost = "I'm lost"
            }
        },
        {
            text = {
                lost = "Oh, you're lost? No worries here, this is a good part of the country. You'll be fine."
            },
            responses = {continue = "Next"}
        },
        {
            text = "Say, do you wanna stay here for a couple nights while you get to your business?",
            responses = {
                yes = "Yes",
                no = "No",
            }
        },
        {
            text = {
                yes = "Splendid! You should go talk to Mike, he can show you around.",
                no = "No? Come on, you really should. Go talk to Mike, he can show you something cool."
            }
        }
    },
    dialogue1 = {
        {
            text = "Hey how are you doing?",
            responses = {
                good = "I'm doing well",
                bad = "I'm doing badly",
            }
        },
        {
            text = {
                good = "That's good to hear!",
                bad = "too bad"
            },
            responses = {
                weather = "Hows the weather?",
                economy = "Hows the economy?",
            }
        },
        {
            text = function(player) return "You are "..player:get_player_name() end
        },
    }
        ]]
}
