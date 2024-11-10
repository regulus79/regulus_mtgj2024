
regulus2024_dialogue.dialogue = {
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
