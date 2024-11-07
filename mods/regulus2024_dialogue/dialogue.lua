
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
