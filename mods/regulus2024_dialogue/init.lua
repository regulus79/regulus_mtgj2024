
regulus2024_dialogue = {}

dofile(minetest.get_modpath("regulus2024_dialogue") .. "/dialogue.lua")

regulus2024_dialogue.set_current_dialogue = function(player, dialogue_id, line_number, previous_response)
    local meta = player:get_meta()
    if dialogue_id == nil then
        meta:set_string("current_dialogue", "")
    else
        meta:set_string("current_dialogue", minetest.serialize({dialogue_id = dialogue_id, line_number = line_number, previous_response = previous_response}))
    end
end

regulus2024_dialogue.get_current_dialogue = function(player)
    local meta = player:get_meta()
    return minetest.deserialize(meta:get_string("current_dialogue"))
end

regulus2024_dialogue.show_current_dialogue_formspec = function(player)
    local current_dialogue = regulus2024_dialogue.get_current_dialogue(player)
    if current_dialogue then
        local dialogue_id = current_dialogue.dialogue_id
        local line_number = current_dialogue.line_number
        local previous_response = current_dialogue.previous_response
        local dialogue_line = regulus2024_dialogue.dialogue[dialogue_id][line_number]
        local formspec = regulus2024_dialogue.construct_dialogue_formspec(player, dialogue_line, previous_response)
        minetest.show_formspec(player:get_player_name(), "regulus2024_dialogue:" .. dialogue_id .. "_line_" .. line_number, formspec)
    end
end

---- AAAAA ADD NPC BACK IN
regulus2024_dialogue.start_dialogue = function(player, dialogue_id)
    -- TODOOOOO
    local dialogue_line_number = 1
    regulus2024_dialogue.set_current_dialogue(player, dialogue_id, dialogue_line_number, nil)
    regulus2024_dialogue.show_current_dialogue_formspec(player)
    --regulus2024_dialogue.show_current_dialogue_formspec(player)
    --local formspec = regulus2024_dialogue.construct_dialogue_formspec(npc, player, dialogue_line, nil)
    --minetest.show_formspec(player:get_player_name(), "regulus2024_dialogue:" .. dialogue_id .. "_line_" .. dialogue_line_number, formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local modname, dialogue_id_plus_line = unpack(string.split(formname, ":"))
    print(formname, dump(fields))
    if modname == "regulus2024_dialogue" then
        local dialogue_id, line_number = unpack(string.split(dialogue_id_plus_line, "_line_"))
        line_number = tonumber(line_number)
        if regulus2024_dialogue.dialogue[dialogue_id][line_number].responses then
            -- If you just pressed esc on a dialogue with responses, reshow the current dialogue.
            if fields.quit then
                regulus2024_dialogue.show_current_dialogue_formspec(player)
                return
            end
            for responseid, _ in pairs(regulus2024_dialogue.dialogue[dialogue_id][line_number].responses) do
                if fields[responseid] then
                    regulus2024_dialogue.set_current_dialogue(player, dialogue_id, line_number + 1, responseid)
                    regulus2024_dialogue.show_current_dialogue_formspec(player)
                    return
                end
            end
        else
            regulus2024_dialogue.set_current_dialogue(player, nil)
            -- Send callback to quests
            regulus2024_quests.on_finish_dialogue(player, dialogue_id)
        end
    end
end)

--- AAAAAAA I want to add npc as a variable in the function for flexability but I don't know how to store it in metadata
regulus2024_dialogue.construct_dialogue_formspec = function(player, dialogue_line, previous_response)
    local text = ""
    if type(dialogue_line.text) == "function" then
        text = dialogue_line.text(player)
    elseif type(dialogue_line.text) == "table" then
        if dialogue_line.text[previous_response] then
            text = dialogue_line.text[previous_response]
        end
    else
        text = dialogue_line.text
    end

    local has_responses = dialogue_line.responses ~= nil
    local responses = {}
    if has_responses then
        for responseid, responsedef in pairs(dialogue_line.responses) do
            if type(responsedef) == "function" then
                responses[responseid] = responsedef(npc, player)
            elseif type(responsedef) == "table" then
                if responsedef[previous_response] then
                    responses[responseid] = responsedef[previous_response]
                end
            else
                responses[responseid] = responsedef
            end
        end
    end

    local text_formspec = table.concat({"label[1,1;", minetest.colorize("#000000", text), "]"}, "")

    local responses_formspec_table = {}
    local i = 0
    for responseid, responsetext in pairs(responses) do
        table.insert(responses_formspec_table, table.concat({
            "image_button[8,", i*0.75 + 1,
            ";3,0.5;regulus2024_dialogue_button6x1.png;",
            responseid, ";",
            minetest.colorize("#000000", responsetext), "]"
        }, ""))
        i = i + 1
    end
    print(dump(responses_formspec_table))

    local formspec = table.concat({
        "formspec_version[7]",
        "size[15,5]",
        "position[0.5,0.75]",
        "style_type[label;font_size=20]",
        "background9[0,0;0,0;regulus2024_dialogue_background1.png;true;16]",
        text_formspec,
        unpack(responses_formspec_table),
    }, "\n")
    return formspec
end

--- tESTING


minetest.register_chatcommand("show_dialogue", {
    description = "show a dialogue",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        regulus2024_dialogue.start_dialogue(player, param)
    end
})