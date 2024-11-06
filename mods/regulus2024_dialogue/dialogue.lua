
regulus2024_dialogue.dialogue = {
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
