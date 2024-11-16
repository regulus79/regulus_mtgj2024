
local books = {
    how_to_cast_spells = {
        title = "How to Cast Spells",
        text = "Just say it.",
        shelf_texture = "regulus2024_book_binding_orange1.png",
    },
    book_of_legends = {
        title = "Book of Legends",
        text = "There is a secret far away near the mountains.",
        shelf_texture = "regulus2024_book_binding_orange2.png",
    },
    etaasjol_yyosojd = {
        title = "Etaasjol Yyosojd",
        text = "Uafosjioijoi sidoiuoi gflokoioiuo doiokskjdgou",
        shelf_texture = "regulus2024_book_binding_orange3.png",
    }
}

local update_bookshelf = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local booklist = inv:get_list("books")

    local formspec_table = {
        "formspec_version[7]",
        "size[12,12]",
        "image[0,0;12,12;regulus2024_bookshelf_top.png]",
        "image[0,0;12,6;regulus2024_bookshelf_shelf.png]",
        "list[context;books;1.75,1.25;7,1]",
        "list[current_player;main;1.2,6;8,4]",
        "listring[context;books]",
        "listring[current_player;main]",
    }
    for i = 1,7 do
        local stack = booklist[i]
        local book_id = string.split(stack:get_name(), "regulus2024_nodes:book_closed_")[1]
        minetest.debug(dump(book_id))
        if book_id then
            table.insert(formspec_table, "image["..(i*1.25 - 0.375 + 0.75)..",1.25;1.25,3.75;"..(books[book_id].shelf_texture or "regulus2024_book_binding_orange1.png").."]")
        end
    end
    meta:set_string("formspec", table.concat(formspec_table, "\n"))
end

for i = 1,1 do
    minetest.register_node("regulus2024_nodes:bookshelf"..i, {
        description = "Test bookshelf",
        tiles = {"regulus2024_bookshelf_top.png","regulus2024_bookshelf_side"..i..".png"},
        groups = {pickaxeable = 1},
        allow_metadata_inventory_put = function(pos, listname, index, itemstack)
            if minetest.get_item_group(itemstack:get_name(), "book") ~= 0 then
                return itemstack:get_count()
            end
            return 0
        end,
        on_metadata_inventory_put = update_bookshelf,
        on_metadata_inventory_take = update_bookshelf,
        on_metadata_inventory_move = update_bookshelf,
    })
end

for i = 1,1 do
minetest.register_abm({
    label = "Initialize Bookshelf"..i.." Metadata",
    nodenames = {"regulus2024_nodes:bookshelf"..i},
    interval = 3,
    chance = 1,
    action = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local books = inv:get_list("books")
        if books == nil then
            inv:set_size("books", 8)
            update_bookshelf(pos)
            minetest.debug("Init bookshelf")
        end
    end
})
end

local book_types = {
    {
        nodebox_open = {
            type = "fixed",
            fixed = {-6/16, -8/16, -4/16, 6/16, -7/16, 4/16}
        },
        nodebox_closed = {
            type = "fixed",
            --fixed = {-3/16, -8/16, -4/16, 3/16, -6/16, 4/16}
            fixed = {-1/16, -8/16, -3/16, 1/16, -2/16, 3/16}
        },
        tiles_open = {
            "regulus2024_book1_front.png",
            "regulus2024_book1_back.png",
            "regulus2024_book1_left.png",
            "regulus2024_book1_right.png",
            "regulus2024_book1_top.png",
            "regulus2024_book1_bottom.png",
        },
        tiles_closed = {
            "regulus2024_book1_front.png",
            "regulus2024_book1_back.png",
            "regulus2024_book1_left.png",
            "regulus2024_book1_right.png",
            "regulus2024_book1_top.png",
            "regulus2024_book1_bottom.png",
        },
    }
}

for bookid, bookcontent in pairs(books) do
    local random_book_type = book_types[math.random(#book_types)]
    local changed_tiles_open = random_book_type.tiles_open -- todo make random colors
    local changed_tiles_closed = random_book_type.tiles_closed -- todo make random colors
    local text = bookcontent.text
    minetest.register_node("regulus2024_nodes:book_open_" .. bookid, {
        description = bookcontent.title,
        tiles = changed_tiles_open,
        paramtype2 = "facedir",
        paramtype = "light",
        drawtype = "nodebox",
        node_box = random_book_type.nodebox_open,
        groups = {breakable_by_hand = 1, book = 1},
        drop = "regulus2024_nodes:book_closed_" .. bookid,
        on_rightclick = function(pos, node, clicker)
            local formspec = table.concat({
                "formspec_version[7]",
                "size[8,8]",
                "label[1,1;", bookcontent.title,"]",
                "label[1,1.5;", text,"]",
            }, "\n")
            minetest.show_formspec(clicker:get_player_name(), "regulus2024_nodes:book_" .. bookid, formspec)
        end
    })
    minetest.register_node("regulus2024_nodes:book_closed_" .. bookid, {
        description = bookcontent.title,
        tiles = changed_tiles_closed,
        paramtype2 = "facedir",
        paramtype = "light",
        drawtype = "nodebox",
        node_box = random_book_type.nodebox_closed,
        groups = {breakable_by_hand = 1, book = 1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above - pointed_thing.under == vector.new(0,1,0) then
                minetest.item_place(ItemStack("regulus2024_nodes:book_open_" .. bookid), placer, pointed_thing)
                return ItemStack("")
            else
                return nil
            end
        end
    })
end