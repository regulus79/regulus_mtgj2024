
local page_character_wrap = 50


local generate_random_book_binding_texture = function()
    local base = "regulus2024_book_binding_redbg.png"
    local colorize = "^[colorizehsl:" .. math.random(-30,30) .. ":" .. math.random(50,100)  .. ":" .. math.random(-50,0)
    local decos = {
        "regulus2024_book_binding_deco1.png",
        "regulus2024_book_binding_deco2.png",
        "regulus2024_book_binding_deco3.png",
        "blank.png",
        "blank.png",
    }
    local deco = decos[math.random(#decos)]
    local shading = "regulus2024_book_binding_shading.png"
    print(base .. colorize .. "^" .. deco .. "^" .. shading)
    return base .. colorize .. "^" .. deco .. "^" .. shading
end


local books = {
    bedroom_book = {
        title = "Lore of the House",
        pages = {
            table.concat({
                minetest.wrap_text("Tyro, si. Se ba ti ge na weme cysi sereso, mesazuje, tetumi, sety te me. Saqadu tete. Te naxu samo fi sa ta. Mu. Le tere, li nesosela cene. Ki ro leve, leruteta se wusi, na te si, ta, ty, losu, fy, hu. Tyri tato, rota ra kede lida sage. Tese soseve betoteve sonyte se, wyto. Rima te to. Resozo. Tany, notimy senuka jotiseti li sevo ro. Mata, je tece te wo, tetela le. Kotesese totete lesi tatane. Letaso we te. Tuti setu. Le qa licumu vete myty ca ryteto. Ra. Te. Te. Sati. Sitere. Ze, me. Latatola, me ricesene.", page_character_wrap),
            }, "\n\n"),
            table.concat({
                minetest.wrap_text("This house is not what it seems. There are many secrets lurking behind the walls.", page_character_wrap),
                minetest.wrap_text("Kora. Re gasede teka suta zo, po rasaleni ta mato po sypa nabe, ta bore sesiteso tupety lutotete ke salete teno. Tene va rito sere. Rele te, teremoce. Beso. Wa, nulore. Retu lepa. Ko matesy tereca. Ce me cacice su sezesase se. Seto. My, minite toxi. Bysetumy si laselosa. Ta rete temeteto. Ki he, se ronose nynama seboreta te. Re, mute te la. Lufe tuna, lasepe. Remeri se tete tele, pa tyju gadose goho wa kebape se te myta, sero fo ce rate le ta, teta tuvetolo ku telotika regete mi zebote ne pe se. Tatetu.", page_character_wrap),
            }, "\n\n"),
            minetest.wrap_text("Te. Xa. Cesa le ha xe, za, sole tata tesihe meryresa beko. Jese. Kise vesitu teto mate tase taselesy tyti, siqe vasocele. Ta ka lesulote raqy te titi lase raka ty zo. Se. Suti, be cexute hege nuse se te ri lu ty totyse ta, setu ca, torele synelele qutytu va. Re tunu, sewa sy rene le latequ. Terete. Natacere keci tu cafepe. Sele ra. Jemerita mupe ta setato, sexe ty lo siso. Susu te xe duso le rokusise, so nazoseta, ni saro ti daki, jilora se le. Ture. Toto sisa. Cobelu ro ke. Ti te, sabe tate sepo.", page_character_wrap),
            minetest.wrap_text("Nehe topana xote. Nesetyte xe teneso sy. Tesutote, zorema, tesecare sa tebe ke, jolyrace deta, to ty to ti taro zy, keky li fate to lutave. Nata. Te seka. Tetexene mi tesa, satela teto, ta vele. Pe. Totuqyqe lexoto sela se pe. Me le te. Tose xo bi ta lu tu. Talu jerele se to se le. Be, seto ce taseto ta te, syti mo, mosate pa niwe. Sesa, ti masita tatale. Teta re, petepusa. Hare, to, hepite te. Temexa xa gytere myzoty. Ty, tatete kutexa to te.", page_character_wrap),
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    bedroom_book2 = {
        title = "Book of Quotes",
        pages = {
            table.concat({
                minetest.wrap_text("The library calls. It brings you freedom. It brings you freedom…. It is behind the wall…. Search for a hidden passageway!", page_character_wrap),
                minetest.wrap_text("Mota. Segity jeta, te, qezise tanoge tete. Ty tate tete teje, sa. Titatyte tysywa. Me, ty mu bi. Su le sere gese. Qe, ba, manete rara ribeta le nohogo kema, diti me meby. Pesa, syta vela lesuse tetaja, sa ma, qata ro. Le. Te sotynefe myte me. Vene, neha. Re ritipe. Tebasu, ta rita ry teti. Ty lole. Tirata bo. Mave. Sytase leze syti be, me. Revotute su to, temote sebe qise raryle, sy, setytono, tysi. Talo su. Ry xi ta nera. Ro mosa ti luse bo nyku me tely, ta ra ko ja. Re jato weta tijese xa.", page_character_wrap),
            }, "\n\n"),
            table.concat({
                minetest.wrap_text("Ta no ne rametite reju ba ra ri sexetada tabe sy movo nosubebi xileluta tuso me lesi, nu ru, bigeso retokoka. Te secejo te tono. Dote. Neta ta te ma. To, le. Coti folu, rera retasezo go toxe zi susenita sewake tete, totanute, tefa wosu. Sede bareka, tytu me kare. Te retira, meme. Ti ry, sete te taty be re sotolafe. Ta ly. Setawate de. Tame letareje labere rete teta toryro ta, lesu qu. Ga mo lato batete le talo totisone le, sa. So. Lotu, ty, sasy. Ze lytati torete renofu, seco newose meta, jeta, ne me soza.", page_character_wrap),
            }, "\n\n"),
            minetest.wrap_text("Nehe topana xote. Nesetyte xe teneso sy. Tesutote, zorema, tesecare sa tebe ke, jolyrace deta, to ty to ti taro zy, keky li fate to lutave. Nata. Te seka. Tetexene mi tesa, satela teto, ta vele. Pe. Totuqyqe lexoto sela se pe. Me le te. Tose xo bi ta lu tu. Talu jerele se to se le. Be, seto ce taseto ta te, syti mo, mosate pa niwe. Sesa, ti masita tatale. Teta re, petepusa. Hare, to, hepite te. Temexa xa gytere myzoty. Ty, tatete kutexa to te.", page_character_wrap),
            
            minetest.wrap_text("Te ti gaty na, taja mera gy sote li. Sefenybi. Tequ, tete cobato mo. Sese. Xesesu pekatu. Roseseti. Xu le ne. Se, poto. Xo. Ta ke. Nytape ta peti, nelese leratoto re, ho te te beze te fasequ. Tusele, tase re, mo pe. To, sasereqe rote pitere, sa pane se, sa tese fu me ka xala rato nityteta, letekyge. Gape lebo bati ny ro re ti fa teme se fesaso saby tase kewa teco tu pose, nivy, tume, sa, tege, wi, totynega, tesita lesa. Da be. Tameho te. La su, cu xate teki mana, ra.", page_character_wrap),
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    bedroom_book3 = {
        title = "Passage",
        pages = {
            table.concat({
                minetest.wrap_text("Spells are dangerous… but they can be useful. I will teach you a simple spell now, the spell of revealing. Stand on the lamp in the floor downstairs and say this: 'reveal et reveala'. Say it. That is all. It will show you passages which are hidden.", page_character_wrap),
                minetest.wrap_text("To re tatali sexehe bope pese nete. Piranaba tewa, syno, tera. Su rany hesa bomyrane. Nu rytuba ta so ma. Zy, te ve sitese texuna kese rage leni tiseta le tetelaxo, me. Xaso, roselyre ki repe tyqu sete te hitare, ra re nese, repipa. Letere, topilara te. Katu. Zu poti te se nifare. Te. Tema tahata, nyla tikosa ne. Losote. Terufo beka dotety ti teta tu, musy to tysu. Totisyte. Ryrenote ta sorevetu, sasane tenowedo. Ma telo. Rasuto lyke teta te paza tavu sytekoto mema la. Sytosa rexe tetuki. Ro tabero. Tefome rati tasa, pe ze sorame. Ja, ba.", page_character_wrap),
            }, "\n\n"),
            table.concat({
                minetest.wrap_text("Kese, nomato. Ty. Wa qata re tozupati, to lekety. Tese tevenuty tebe. Pe la. Tema. Ta ve, ce mehe nepalo, se, ta, lepy, niri lagy. Lebete ceso botory, fa giqa re ta gene tatesane te no tate. Ro nijehe bese la petete sici terece semewe tety, ti, te nili retyte ce, tely. Helate. Tehe su misorito ty to. Pe robemedo, ka ra te leseto qe, nike fe, rylony ti qybetino. Rate, kytatu kymere sepa ryje. Ny ta reva, pe nozite qacaxyte kyha lepenety hete nu tunaca, xaje. Kasejafy pite za, melece so sehatole se, sy, lora seno.", page_character_wrap),
            }, "\n\n"),
            minetest.wrap_text("Beto kupeto zosa teresy tetese ry lero ne te ho segejate se ra liniro teto hi tetu tesula, te. Lemele lyta sete. Ta totuce se sa, netata tegono ce. Sapata, tijymi tony mero. Camoro bo, wa some tase co. Te tetoca motenuro rate xaxure zare lalo peta, mele, tysuga, la. Kose. Qase, to. Tyra zacase. Sy volone ci xutere ta to sete saso fa. Zateta tesy ceroxe peresoge ge mete. Mu. Tecetysa ke te, ruto so. Peto. Notowo tyta metali vaqu ta resafa, peretype. Totata si, talesa, kawi, vese za resu se. Mety. Siseca saru, taseto wereze saru.", page_character_wrap),
            minetest.wrap_text("Tu rexa, tume. Sy pelate ty bo. Ta lileso, setela ta meleta lebu tati, tu li, te lese tete tuse sa. Lenehe. Ge ti rato ra sisa. Tita, tololire caseke tu, tece. Co. Re gisi tule te so, meha ka, te titece to. Se. Dera nasa se, le. Ce sa resali mado, sysasate, ratere. Buge, to, sa fa sa. Sycosu tu sa, mu, sola, pa. Tihasi. Fece tone tyrare rimana se leta lote, moqu my koreselu teru, kebi, tinotato tebi te te teleso da, qase de be bosoto. Soleqe se busasoca ru be.", page_character_wrap),
            
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    the_book_of_banishment = {
        title = "The Book of Banishment",
        pages = {
            table.concat({
                minetest.wrap_text("You want to banish the darkness? A very noble task. Gather the four precious books and place each one on the pedestals, then cast the spell.", page_character_wrap),
                minetest.wrap_text("Li. Ry. Te. Ri. Cuje qale, qi sate, tale. Ty nysede se. Deterese sytera. Re lacosiwe, xyreta ti, teme cyma, tale pesati, ta kose. Wece. Je gosidare funece siteta leri qo zo ne. Te tery. Me. Te rete, pa to ra. Lo tu te. Sytonine kale se, tu ruta, natuty leniso teso. Sego co, sa to ti seresama be. To neto. Seleli te re gosataro tisa sote tejira, re de tevu wata myfu be tave. Te telo talatyto tefaleta ri vasyde tita de, tyte ra. Ritesupu satu tote qete. Rimy. Be. Muve na, se le tata to matene, neva.", page_character_wrap),
            }, "\n\n"),
            table.concat({
                minetest.wrap_text("Sepe botabo. Tome te telu qotetehe. Taly, tygyte. Tese taqapo ku roso gizoty. Meji se. Ti mega. Re metona carawe. Kene ve ru rore. Sefo kajexa satalu. Tetitale. Sytovo. Bega sa letowa leli ne tera sine tepe se ma. Tipelani ga, se te te, ta. He se, nasile tivuca ge, re lany ta, ry rege xato, hatateti. Rere sa. To, ra re ra fery sahe, ra sekajovo tyro ko to tesatege neco pelo si sa dase li neketyca te. Wa. Pyte, tete lo re mepeta, fetita pate tura se tena te tube sityto, tole lato fyce mi setu te tetose.", page_character_wrap),
                minetest.wrap_text("Find The Book of Light, and find The Book of Darkness. Find The Book of Truth, and find The Book of Lies.", page_character_wrap),
            }, "\n\n"),
            table.concat({
                minetest.wrap_text("The spell is simple. Stand amists the four books upon the four pedestals, and proclaim: banisha darknessa. If you have done correctly, the darkness will be no more.", page_character_wrap),
                minetest.wrap_text("Feke wu dabere halisecy, ji liro rato lurete, te, caza mesa. Te nalera, sa le. Tawete sa. Mo, xe netisetu te, rerepa. Po raserete bosele. Qenu sito ni. Ne le sije po lasesa co ta, ba totaso jole lemaxe, cete. Kesoty ta ve, qe ta ja bosisyso, ra so na. Be tojose se. Ra metado qa mosa tu sapukazy sate hy ro ta, ja totete fa jenase. Tane, re, lysebo sytetapa bo, jotu ro gaty xame la se no, leto liteqa. Te, zo qipete letete mypama. Mi tese tene ni cesa. Sopa ja. Tesylusa xe ge vo mizase.", page_character_wrap),
            }, "\n\n"),
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    the_book_of_light = {
        title = "The Book of Light",
        pages = {
            minetest.wrap_text("Du toze, to dyce ryta li suba te pilasa. Le se, ta so so, temy. Na xa wesi, se fe. Totyla tavu taso xose, tu, temo tobo xe lu noteha ti tetu, qelase tu te vete terexe sa tobetima, re. Sesa pa casate sela ty re le ty. Tema selesase ta. Toseta ti. Ce. Ve pege. Py tinoty. Melalose zelejeca. Gita hy. Ko semitele lanuta. Te. Xabe ty, se teci losecaco, saliqe si. Pi ta, sete tyfata tema ta to pe me. Sata. Ta pe, rave, te ty nutaqu me. No sa te ce mece.", page_character_wrap)
        },
        shelf_texture = "regulus2024_book_binding_whitebg.png^regulus2024_book_binding_shading.png",
    },
    the_book_of_darkness = {
        title = "The Book of Darkness",
        pages = {
            minetest.wrap_text("Ze lepe neweso. Coma titohu rejeru vinyha cala, cota ni. Telete take ketu so. Ta. Tesela gitaba se soba setare bu se. Sose nasyte. Tame. Sityve. De. Te. Luti lo. Muluse mete lateta tite re sato to. Pizitaca. Tere zo, bete metiru sanalofa mete resa sa ca leto baqo. La, ru, metevesi veti ta ta, lesake ba, re, vevosa, de, lysate. Ca ro tapare tese re nejo tara kesu, tagene. Ce nasa. Le pe metese. Li, temate so motase qe. Vana rysa tity reti tata, sa ke ta tena. Laqarytu so. Qypube tamonexu sesy.", page_character_wrap)
        },
        shelf_texture = "regulus2024_book_binding_whitebg.png^[colorizehsl:0:0:-80^regulus2024_book_binding_deco1.png^regulus2024_book_binding_shading.png",
    },
    the_book_of_truth = {
        title = "The Book of Truth",
        pages = {
            minetest.wrap_text("Pe, te tu, bo me. Seqeteco tutabe ta, note, sa. We, ge. Kale. Ta za he se. Zeti gute sa nolenu rytytebe. Matyve pa noso, we mo le so qe. Ve, tutati. Xesefo tita pozurawo, tero lynataty. Talame, xa. Le, loto pa teto. Te tyrabe tate, tu meteti, ha wete, te. Ce retitepe je te, sumese. Tare. Me. Si kate te. Sa pi mi. Ce tyle, nesi, ka teta, ta raqo, cy, jece, ryta sosa, sylete nelese ta. Fyreme nigijare tatese. Be josite. Retosete tasera te suna to talu xyse catite.", page_character_wrap)
        },
        shelf_texture = "regulus2024_book_binding_whitebg.png^regulus2024_book_binding_deco2.png^regulus2024_book_binding_shading.png",
    },
    the_book_of_lies = {
        title = "The Book of Lies",
        pages = {
            minetest.wrap_text("Pete, lo myto tunebeba zatomepe ne, resi, sa ratu sate, kemotu teru mele. Ciresere liso. Noti lo, xehe bete pe. Jotepoti, nyla sa, bora, luza pute, py tewo. Lenabete neripama tereba. Sa tote, bo. Sy taze, tirefufa coju lodasa ty. Li. So seri. Tysa se cata seby, goko resitame sese tanivu pe ce. Te toha te jyne, qudo cehusete nase. Be, ty. Tonesexe. Na te, te, ta tatituxe. Pepere. Se paqeve. Lu fe tetata meba tene nuse, sevata mi, tase la. Be case ke. Sy lisese sa sace te tosirope sokexi, tena maneta lotesu.", page_character_wrap)
        },
        shelf_texture = "regulus2024_book_binding_whitebg.png^[colorizehsl:0:0:-50^regulus2024_book_binding_deco3.png^regulus2024_book_binding_shading.png",
    },
    -- random books?
    how_to_cast_spells = {
        title = "How to Cast Spells",
        pages = {
            "Just say it."
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    book_of_legends = {
        title = "Book of Legends",
        pages = {
            "Just say it."
        },
        shelf_texture = generate_random_book_binding_texture(),
    },
    etaasjol_yyosojd = {
        title = "Etaasjol Yyosojd",
        pages = {
            "Just say it."
        },
        shelf_texture = generate_random_book_binding_texture(),
    }
}

local random_sentences = {
    "Taro, wetify, rase. La bamo, sase setutise. Ta, se se, to kese tetetitu se ta zetenyso tu tutote, re cywe.",
    "Pelateqa. Hatese cy ta to muve nyrako. Botely la getele tetete, sesysaxu cerebo talosa, relo caje se toterije litytyre, tate.",
    "Teteny ne. Ru gy vy mano gase ti teta za, ne xy ty tale, ru tamata, rudi za teseke, lu.",
    "Ta te, tefi, te to ty sa ry ralyly. Pi si tecete te. No ce, re nu, liteso poti tele.",
    "To, ti cujy tato semateza sabo kosa, tenora qi lere pese, zomoly qa, tesateta tetata paca seha lete lotesepa dy.",
    "Be te. Meso totura de sefilu toro vo, ti, to te me xe tela tilo. Za, vatuhita nure, to he.",
    "Fesa, ruvetetu capa jeto, fama ledene. Tetu noke wysosa, syri te susa bevamu donetale sewewo lyresymo taje dolodela titeke, ro.",
    "Vo suja. Mebazata je ra, tesely tuhe, bi, time bisiwa sito setusano. Be, pi sonewe leherepe. Ce sotete sytefe.",
    "Pa, sy tyle. Zura tocibuse. Kyla si. Zu, teta tena satytole ra, to te. Tesa. Nomo, ta, te tote, te.",
    "Ta to. So, ty. Lute hetoty nesele rosetase xaxo, ku ri sule rone se. Sa, be te. Ne ra nete ta, taga taru serypo.",
    "Karesose, tuwota caso, tije peve, ta, te te re ce tita. Tusetase te jatesupo ba tego kemo be sete secy, dese, rote se ve le. Tasa he. Tateryte.",
    "Ta fy. Tetetice retete zota. Setu ma tane lepizahi, teba ku to ro takybeno tato tatu, ce. Lete ra te titoca zitere hisu, ne titeti to, xebe. Ry.",
    "Tosa rexa lete ty. Bapose be keta tu. Nu sa se no rona, te ce vuna te tu, basore ne fe ne tebe, ta lo tazitesy myluteto se.",
    "Ta ti. Tale, ma. Ma saluxy taqe toletute teca mare togi viso. Te tu jofe, fabeneta posisy tora, molala se, cezo wa wely teta sa le syta keqe.",
    "Ni. To tuta sene tose, te. Su patete seromo tepu metehe, sapute tanetase tere tene cewele qu. Ho, tati fakico pe. Ni, roteju te tamy, pomo toho, duce se te.",
}
local title_words = {
    "Fesa",
    "Tetu",
    "Teteny",
    "Taro",
    "Pelateqa",
    "Zomoly",
    "Donetale",
    "Ruvetetu",
    "Neneteta",
    "Totatoqo",
    "Pajyqosi",
    "Vole",
    "Syde",
    "Tase",
    "Vata",
    "Totofe",
    "Setetusi",
    "Tasyte",
    "Nekaso.",
    "Lytetamu",
    "Deremy",
    "Kereme",
    "Rotehafi",
    "Benety",
    "Talaty",
    "Retosose",
    "Loge.",
}


local random_books = {
}

for i = 1, 30 do
    local pages = {}
    for i = 1, math.random(5) do
        pages[i] = minetest.wrap_text(random_sentences[math.random(#random_sentences)] .. " " .. random_sentences[math.random(#random_sentences)] .. " " .. random_sentences[math.random(#random_sentences)], page_character_wrap)
    end
    books["random"..i] = {
        title = title_words[math.random(#title_words)] .. " " .. title_words[math.random(#title_words)],
        pages = pages,
        shelf_texture = generate_random_book_binding_texture(),
    }
    table.insert(random_books, "random"..i)
end

local update_bookshelf = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local booklist = inv:get_list("books")

    local formspec_table = {
        "formspec_version[7]",
        "size[12,12]",
        "image[0,0;12,12;regulus2024_bookshelf_top.png]",
        "image[0,0;12,6;regulus2024_bookshelf_shelf.png]",
        "list[context;books;1.75,-100;7,1]",
        "list[current_player;main;1.2,7;8,4]",
        "listring[context;books]",
        "listring[current_player;main]",
    }
    for i = 1,7 do
        local stack = booklist[i]
        local book_id = string.split(stack:get_name(), "regulus2024_nodes:book_closed_")[1]
        if book_id then
            table.insert(formspec_table, "image_button["..(i*1.25 - 0.375 + 0.75)..",1.25;1.25,3.75;"..(books[book_id].shelf_texture or "regulus2024_book_binding_orange1.png")..";"..i..";]")
            table.insert(formspec_table, "tooltip["..i..";"..books[book_id].title.."]")
        end
    end
    meta:set_string("formspec", table.concat(formspec_table, "\n"))
end

local bookshelf_types = {
    "random",
    "bedroom",
    "library1",
    "library2",
    "library3",
    "library4",
}

for _,bookshelf_type in pairs(bookshelf_types) do
    local texture = "regulus2024_bookshelf_front6.png"
    if bookshelf_type == "random" then
        texture = "regulus2024_bookshelf_front5.png"
    end
    minetest.register_node("regulus2024_nodes:bookshelf_" .. bookshelf_type, {
        description = "Test bookshelf " .. bookshelf_type,
        tiles = {"regulus2024_bookshelf_top.png", texture},
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
        on_receive_fields = function(pos, formname, fields, sender)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local booklist = inv:get_list("books")
            for k,v in pairs(fields) do
                if tonumber(k) then
                    sender:get_inventory():add_item("main", booklist[tonumber(k)])
                    local book_id = string.split(booklist[tonumber(k)]:get_name(), ":book_closed_")[2]
                    regulus2024_quests.on_get_book(sender, book_id)
                    booklist[tonumber(k)] = ""
                end
            end
            update_bookshelf(pos)
            minetest.after(0, function() update_bookshelf(pos) end)
            inv:set_list("books", booklist)
        end,
    })
end


for _,bookshelf_type in pairs(bookshelf_types) do
    minetest.register_abm({
        label = "Initialize Bookshelf "..bookshelf_type.." Metadata",
        nodenames = {"regulus2024_nodes:bookshelf_"..bookshelf_type},
        interval = 3,
        chance = 1,
        action = function(pos)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local books = inv:get_list("books")
            if books == nil then
                local booklist = {"","","","","","",""}
                if bookshelf_type == "random" or  bookshelf_type == "library1" or bookshelf_type == "library2" or bookshelf_type == "library3" or bookshelf_type == "library4" then
                    for i = 1,7 do
                        if math.random()<0.9 then
                            booklist[i] = "regulus2024_nodes:book_closed_" .. random_books[math.random(#random_books)]
                        else
                            booklist[i] = ""
                        end
                    end
                end
                if bookshelf_type == "bedroom" then
                    local rand = math.random(6)
                    booklist[rand] = "regulus2024_nodes:book_closed_bedroom_book2"
                    booklist[rand + math.random(7 - rand)] = "regulus2024_nodes:book_closed_bedroom_book3"
                end
                if bookshelf_type == "library1" then
                    local rand = math.random(7)
                    booklist[rand] = "regulus2024_nodes:book_closed_the_book_of_light"
                end
                if bookshelf_type == "library2" then
                    local rand = math.random(7)
                    booklist[rand] = "regulus2024_nodes:book_closed_the_book_of_darkness"
                end
                if bookshelf_type == "library3" then
                    local rand = math.random(7)
                    booklist[rand] = "regulus2024_nodes:book_closed_the_book_of_truth"
                end
                if bookshelf_type == "library4" then
                    local rand = math.random(7)
                    booklist[rand] = "regulus2024_nodes:book_closed_the_book_of_lies"
                end
                inv:set_list("books", booklist)
                update_bookshelf(pos)
            end
        end
    })
end

local book_types = {
    {
        nodebox_open = {
            type = "fixed",
            fixed = {
                {-6/16, -8/16, -4/16, 6/16, -7/16, 4/16},
                {-5/16, -7/16, -3/16, 0/16, -6.5/16, 3/16},
                {0/16, -7/16, -3/16, 5/16, -6.5/16, 3/16},
            }
        },
        nodebox_closed = {
            type = "fixed",
            --fixed = {-3/16, -8/16, -4/16, 3/16, -6/16, 4/16}
            fixed = {
                {-1/16, -8/16, -3/16, 1/16, -3/16, 3/16},
                {-1.5/16, -8/16, -4/16, -1/16, -2/16, 4/16},
                {1/16, -8/16, -4/16, 1.5/16, -2/16, 4/16},
            }
        },
        tiles_open = {
            "regulus2024_book1_front.png",
            "regulus2024_book1_back.png",
            "regulus2024_book1_top.png",
            "regulus2024_book1_top.png",
            "regulus2024_book1_top.png",
            "regulus2024_book1_top.png",
        },
        tiles_closed = {
            "regulus2024_book1_front_closed.png",
            "regulus2024_book1_back.png",
            "regulus2024_book1_side_closed.png",
            "regulus2024_book1_side_closed.png",
            "regulus2024_book1_front_closed.png",
            "regulus2024_book1_front_closed.png",
        },
    }
}

local show_book_page = function(player, bookid, pagenumber)
    -- Don't allow even page numbers to be shown, otherwise the righthand page will be on the left and vice versa
    if pagenumber%2 ~= 1 then
        pagenumber = pagenumber - 1
    end
    local textleft = books[bookid].pages[pagenumber] or ""
    local textright = books[bookid].pages[pagenumber + 1] or ""
    local formspec = table.concat({
        "formspec_version[7]",
        "size[18,12]",
        "background[0,0;18,12;regulus2024_book_gui_background.png]",
        --"label[1,1;", bookcontent.title,"]",
        "label[1.5,1;", minetest.colorize("#000000", textleft),"]",
        "label[10,1;", minetest.colorize("#000000", textright),"]",
        (pagenumber > 2 and ("image_button[0,5.5;1,1;regulus2024_book_left_button.png;" .. pagenumber - 2 .. ";]") or ""),
        (pagenumber + 2 <= #books[bookid].pages and ("image_button[17,5.5;1,1;regulus2024_book_right_button.png;"  .. pagenumber + 2 ..  ";]") or ""),
        "style_type[image_button;bgimg=blank.png;bgimg_hovered=blank.png;bgimg_pressed=blank.png;bgcolor_hovered=#ffffff;bgcolor_pressed=#ffffff;border=false]",
    }, "\n")
    minetest.show_formspec(player:get_player_name(), "regulus2024_nodes:book_" .. bookid, formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local _, formname_split, bookid = unpack(string.split(formname, "_", false, 2))
    if formname_split and bookid and formname_split == "nodes:book" and books[bookid] then
        for i, v in pairs(fields) do
            if tonumber(i) then
                show_book_page(player, bookid, tonumber(i))
            end
        end
        if fields.quit then
            regulus2024_quests.on_read_book(player, bookid)
        end
    end
end)

for bookid, bookcontent in pairs(books) do
    local random_book_type = book_types[math.random(#book_types)]
    local changed_tiles_open = random_book_type.tiles_open -- todo make random colors
    local changed_tiles_closed = random_book_type.tiles_closed -- todo make random colors
    local pages = bookcontent.pages
    minetest.register_node("regulus2024_nodes:book_open_" .. bookid, {
        description = bookcontent.title,
        tiles = changed_tiles_open,
        paramtype2 = "facedir",
        paramtype = "light",
        drawtype = "nodebox",
        node_box = random_book_type.nodebox_open,
        groups = {breakable_by_hand = 1, book = 1},
        stack_max = 1,
        drop = "regulus2024_nodes:book_closed_" .. bookid,
        after_place_node = function(pos)
            minetest.get_meta(pos):set_string("infotext", bookcontent.title)
        end,
        on_rightclick = function(pos, node, clicker)
            show_book_page(clicker, bookid, 1)
        end
    })
    minetest.register_node("regulus2024_nodes:book_closed_" .. bookid, {
        description = bookcontent.title,
        tiles = changed_tiles_closed,
        paramtype2 = "facedir",
        paramtype = "light",
        drawtype = "nodebox",
        node_box = random_book_type.nodebox_closed,
        stack_max = 1,
        groups = {breakable_by_hand = 1, book = 1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above - pointed_thing.under == vector.new(0,1,0) then
                minetest.item_place(ItemStack("regulus2024_nodes:book_open_" .. bookid), placer, pointed_thing)
                --minetest.get_meta(pointed_thing.above):set_string("infotext", bookcontent.title)
                return ItemStack("")
            else
                return nil
            end
        end
    })
end