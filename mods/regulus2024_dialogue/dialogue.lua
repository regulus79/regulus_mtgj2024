
regulus2024_dialogue.dialogue = {

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


    dni1 = {
        {
            text = function()
                local lines = {
                    "I'm busy right now, come back later.",
                    "I can't talk right now.",
                    "Don't talk to me.",
                    "I don't have anything to tell you right now.",
                    "Leave me alone.",
                }
                return lines[math.random(#lines)]
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
}
