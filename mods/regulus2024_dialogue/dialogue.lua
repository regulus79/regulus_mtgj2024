
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
            text = "Don't talk to me.",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "No, I don't take visitors.",
            responses = {monster = "Do you know anything about the monster?"}
        },
        {
            text = "The monster? Sir, do not speak of it. Not at this hour. If it hears you it will come kill us all!",
        },
    },
    find_a_place_to_stay2 = {
        {
            text = "I'm busy, leave me alone.",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "No, find someone else.",
            responses = {monster = "Do you know anything about the monster?"}
        },
        {
            text = "Why do you ask about it? It killed my father. That wretched beast! \nIf I had the power to kill it, I would. But alas we live under constant fear of it.",
        },
    },
    find_a_place_to_stay3 = {
        {
            text = "What do you want?",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "Stay for the night? Nay, I do not have space. Nor enough food to share. I heard the old wizard down there is quite hospitable, maybe you should try him.",
            responses = {monster = "Do you know anything about the monster?"}
        },
        {
            text = "Yes, it's a terrible plague for us. Some nights you can see it flying high overhead. It sends chills down my back.",
        },
    },
    ask_wizard_for_place_to_stay = {
        {
            text = "What's going on, young one?",
            responses = {stay = "Do you have a place I could stay the night?"}
        },
        {
            text = "Hm, alright. I see something about you I haven't seen in a long time. Why don't you come in with me, let me get you some supper.",
        },
    },
    talk_to_wizard_again = {
        {
            text = "What were you asking those people about? They seemed frightened.",
            responses = {monster = "I asked them about the monster"},
        },
        {
            text = "Ah yes. Everyone in the village has had some encounter with it. For some it killed their family, others their friends.",
            responses = {you_wizard = "Are you the wizard who tried to kill it?"},
        },
        {
            text = "Am I the wizard? No, no. He was my mentor. This house is where he lived.",
            responses = {next = "next"},
        },
        {
            text = "I still remember the day he left and fought the monster, 100 years ago.",
            responses = {next = "next"},
        },
        {
            text = "I was still being trained at the time. I did not have the skill or the courage to help defend. But he, he bravely fought the monster and drove it back to it's den, far far away.",
            responses = {next = "next"},
        },
        {
            text = "Everyone, including me, was ready to celebrate when he came back victorious having killed the monster. But… he never did. I… I'm sorry, just give me a moment.",
            responses = {next = "next"},
        },
        {
            text = "My training was not finished when he departed. But I spent my time studying his books and scrolls.",
            responses = {next = "next"},
        },
        {
            text = "He was a master wizard, and I do not think I shall ever equal him.",
            responses = {next = "next"},
        },
        {
            text = "I used my little knowledge to protect the village. I have spent my strength casting spells to keep this village hidden from the eyes of the monster.",
            responses = {next = "next"},
        },
        {
            text = "But alas, I am growing old. It is not natural to live this long, and my strength has been steadily diminishing. I cannot protect the village forever.",
            responses = {old = "How old are you?"},
        },
        {
            text = "Very old, young one. But I'm not immortal. I think that living in this house ... it has done something to me.",
            responses = {next = "next"},
        },
        {
            text = "My life has been prolonged. Unnaturally.",
            responses = {next = "next"},
        },
        {
            text = "One day, decades ago, I started on a journey to the nearby town, but as I walked away out of sight of this house, all my strength left me, and I almost collapsed.",
            responses = {next = "next"},
        },
        {
            text = "This house keeps me alive. I cannot leave it.",
            responses = {next = "next"},
        },
        {
            text = "...",
            responses = {next = "next"},
        },
        {
            text = "The reason you came here was to find a place to stay the night, yes?",
            responses = {next = "next"},
        },
        {
            text = "There's a bedroom for you upstairs.",
            responses = {thanks = "Thank you"},
        },
        {
            text = "I sense something special about you... I could really use your help. Please stay as long as you wish.",
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
