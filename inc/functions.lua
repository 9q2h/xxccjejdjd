--[[
#---------------------------------------------------------------------
]]

if cmd == "biouser" then
return SendMention(ChatID,UserID,MsgID,"~ ⪼ النبذه\n\n "..biouser.."",37,USERCAR)
end

function dl_cb(a,d)  end

function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function UpdateNewQuery(data)
msg = {} 
local TextCmdquery = data.payload_.data_ 
local UserID = data.sender_user_id_
local ChatID = data.chat_id_
local dataid = data.message_id_
msg = data

if TextCmdquery == "GroupSitting" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateGropSitting(msg)
elseif TextCmdquery == "MediaSitting" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateMediaSitting(msg)
elseif TextCmdquery == "OtherSetting" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateOtherSitting(msg)
elseif TextCmdquery == "List1" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM1Query(msg)
elseif TextCmdquery == "List2" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM2Query(msg)
elseif TextCmdquery == "List3" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM3Query(msg)
elseif TextCmdquery == "List4" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM4Query(msg)
elseif TextCmdquery == "CmdSudo" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM5Query(msg)
elseif TextCmdquery == "CmdFiles" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
return UpdateM6Query(msg)
elseif TextCmdquery == "LoginOut" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
msg.Delete = true
msg.textmsg = "- تم اخفاء قائمة الاوامر"
msg.Editeinline = true
return SendMsgInline(msg)
elseif TextCmdquery == "CmdBack" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
msg.textmsg = [[ للاستفسار - []]..SUDO_USER..[[]
‏‌‌‏‌‌‌‌‏                                    
*⇜ هلا فيك في اوامر البوت*
]]
msg.KeyboardCmd = keyboardCmd
msg.Editeinline = true
return SendMsgInline(msg)
elseif TextCmdquery == "CmdBack1" then
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
msg.textmsg = [[ للاستفسار - []]..SUDO_USER..[[]

*⇜ هلا فيك في اوامر البوت‏‌‌‏‌‌‌‌‏*
]]
msg.KeyboardCmd = keyboardSitting
msg.Editeinline = true
return SendMsgInline(msg)
end

--=================================================================================
local TextCmd,CmdSitting = TextCmdquery:match("^(Sitting[123])#([%a%d_:]+)$")
print(CmdSitting)
if CmdSitting then
local ResRedis =  redis:del(boss..CmdSitting..msg.chat_id_)
if TextCmd == "Sitting3" then 
if (CmdSitting == "antiedit") and not Get_Rtb(msg,"SuperCreator") then return  answerCallbackQuery(data.id_,"لا تبعص",true) end
if (CmdSitting == "lock_linkk" or CmdSitting == "lock_takkl" or CmdSitting == "lock_leftgroup" or CmdSitting == "lock_KickBan") and not Get_Rtb(msg,"Creator") then
return  answerCallbackQuery(data.id_,"لا تبعص",true) end
if (CmdSitting == "lock_RandomRdod" or CmdSitting == "lock_rdodSource" or CmdSitting == "lock_cleaner" or CmdSitting == "idphoto") and not Get_Rtb(msg,"Director") then
return  answerCallbackQuery(data.id_,"لا تبعص",true) end
end      
if not CheckUserAdmin(msg) then return answerCallbackQuery(data.id_,"لا تبعص",true) end
if ResRedis == 0 then redis:set(boss..CmdSitting..msg.chat_id_,true) end
if TextCmd == "Sitting1" then 
UpdateGropSitting(msg)
elseif TextCmd == "Sitting2" then 
UpdateMediaSitting(msg)
elseif TextCmd == "Sitting3" then 
UpdateOtherSitting(msg)
end
return false
end
--=================================================================================
local Text,UserJoin = TextCmdquery:match("^(CheckRobotJoin:)(%d+)$")
local UserJoin = tonumber(UserJoin)
if Text == "CheckRobotJoin:" then
if CheckUserAdmin(msg) or UserID == UserJoin then
Restrict(ChatID,UserJoin,2)
EditMsg(ChatID,dataid,"تم التاكد بانك شخص حقيقي مو زومبي")
answerCallbackQuery(data.id_,"تقدر ترسل الحين",true)
else
answerCallbackQuery(data.id_,"انت الشخص الي مو مقييد او مامعك صلاحيه الاداره، اسفين",true)	
end
end
end

keyboardCmd = [[{
"inline_keyboard": [
[{"text": "م1","callback_data": "List1"},{"text": "م2","callback_data": "List2"},{"text": "م3","callback_data": "List3"}],
[{"text": "الالعاب","callback_data": "CmdSudo"},{"text": "السورس","callback_data": "List4"}],
[{"text": "","callback_data": "LoginOut"}]
]}
]]


keyboardSitting = [[{"inline_keyboard": [
[{"text": "- اعدادات المجموعة","callback_data": "GroupSitting"},{"text": "- اعدادات الوسائط","callback_data": "MediaSitting"}],
[{"text": "- اعدادات اخرى","callback_data": "OtherSetting"},{"text": "","callback_data": "LoginOut"}]
]}
]]



--================================{{  SendinlineCmd  }} ===================================

function SendMsgInline(msg)
if msg.Editeinline then 
Method = ApiToken.."/editMessageText"
Edite  = "&message_id="..msg.message_id_/2097152/0.5
else 
Method = ApiToken.."/sendMessage" 
Edite  = "&reply_to_message_id="..msg.id_/2097152/0.5
end
if msg.Delete then 
RApi = "&parse_mode=markdown&disable_web_page_preview=true"
else
RApi = "&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..URL.escape(msg.KeyboardCmd)
end
rr,res=https.request(Method..'?chat_id='..msg.chat_id_..'&text='..URL.escape(msg.textmsg)..Edite..RApi)
if res == 200 then return false end
print(rr)
end
function UpdateM1Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "م2","callback_data": "List2"},'..'{"text": "م3","callback_data": "List3"}],'
..'[{"text": "Back ","callback_data": "CmdBack"},{"text": "","callback_data": "LoginOut"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[
 *اوامر الاداره*  

 *اوامر الرفع والتنزيل*
⇜  مالك اساسي    ( رفع ⟺  تنزيل )
⇜  مالك               ( رفع ⟺  تنزيل )
⇜  مشرف            ( رفع ⟺  تنزيل )
⇜  مدير               ( رفع ⟺  تنزيل )
⇜  ادمن              ( رفع ⟺  تنزيل )
⇜  مميز              ( رفع ⟺  تنزيل )
⇜  تنزيل الكل ⤌ لأزاله جميع الرتب أعلاه

  *اوامر المسح*  
⇜   مسح المالكين الاساسيين
⇜   مسح المالكين
⇜  مسح المدراء
⇜   مسح الادمنيه
⇜   مسح المميزين
⇜   مسح المحظورين
⇜   مسح المكتومين
⇜   مسح قائمه المنع
⇜   مسح الردود
⇜   مسح الاوامر
⇜   مسح + عدد
⇜   مسح بالرد
⇜   مسح  الايدي
⇜   مسح الترحيب
⇜   مسح الرابط

 *اوامر الطرد الحظر الكتم*  
⇜  حظر 
⇜  طرد  
⇜  كتم 
⇜  تقيد 
⇜  الغاء الحظر 
⇜  الغاء الكتم 
⇜  فك التقييد 
⇜  رفع القيود - لفك ↜ كتم،حظر،تقييد
⇜  منع + الكلمه
⇜ منع بالرد على ملصق او متحركه
⇜  الغاء منع + الكلمه
⇜  طرد البوتات
⇜  طرد المحذوفين
⇜  كشف البوتات
]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m1:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end
function UpdateM2Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "م1","callback_data": "List1"},'..'{"text": "م3","callback_data": "List3"}],'
..'[{"text": "Back ","callback_data": "List1"},{"text": "","callback_data": "LoginOut"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[
 *اوامر الوضع*  
⇜  ضع الترحيب
⇜  ضع القوانين
⇜  ضع وصف
⇜  ضـع رابط
⇜  تغيير امر
⇜  تعيين الايدي

 *اوامر رؤية الاعدادات*  

⇜  المطورين
⇜  المالكين الاساسين
⇜  المالكين 
⇜  المدراء
⇜  الادمنيه
⇜  المميزين
⇜  المحظورين
⇜  القوانين
⇜  المكتومين
⇜  المطور 
⇜  معلوماتي 
⇜  الحمايه  
⇜  الوسائط
⇜  الاعدادت
⇜  المجموعه
]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m2:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end

function UpdateM3Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "الالعاب","callback_data": "CmdSudo"},'..'{"text": "السورس","callback_data": "List4"}],'
..'[{"text": "Back ","callback_data": "CmdBack"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[
 *اهلاً بك في قائمة الحماية*

 *اوامر القفل والفتح بالمسح*

⇜ قفل ⤜ ⤛ فتح  التعديل  
⇜ قفل ⤜ ⤛ فتح  البصمات 
⇜ قفل ⤜ ⤛ فتح  الفيديو 
⇜ قفل ⤜ ⤛ فتح  الـصــور 
⇜ قفل ⤜ ⤛ فتح  الملصقات 
⇜ قفل ⤜ ⤛ فتح  الملفات  
⇜ قفل ⤜ ⤛ فتح  المتحركه 
⇜ قفل ⤜ ⤛ فتح  الدردشه 
⇜ قفل ⤜ ⤛ فتح  الروابط 
⇜ قفل ⤜ ⤛ فتح  الهاشتاق 
⇜ قفل ⤜ ⤛ فتح  البوتات 
⇜ قفل ⤜ ⤛ فتح  المعرفات 
⇜ قفل ⤜ ⤛ فتح  البوتات بالطرد 
⇜ قفل ⤜ ⤛ فتح  الاشعارات 
⇜ قفل ⤜ ⤛ فتح  الكلايش 
⇜ قفل ⤜ ⤛ فتح  التكرار 
⇜ قفل ⤜ ⤛ فتح  التوجيه 
⇜ قفل ⤜ ⤛ فتح  الانلاين 
⇜ قفل ⤜ ⤛ فتح  الجهات 
⇜ قفل ⤜ ⤛ فتح  الــكـــل 
⇜ قفل ⤜ ⤛ فتح  السب
⇜ قفل ⤜ ⤛ فتح  الفارسيه
⇜ قفل ⤜ ⤛ فتح  الانجليزيه
⇜ قفل ⤜ ⤛ فتح  الاضافه
⇜ قفل ⤜ ⤛ فتح  الصوت
⇜ قفل ⤜ ⤛ فتح  الالعاب
⇜ قفل ⤜ ⤛ فتح  الماركدوان
⇜ قفل ⤜ ⤛ فتح  الويب

 *اوامر الفتح والقفل بالتقييد* 

⇜ قفل ⤜ ⤛ فتح التوجيه بالتقييد 
⇜ قفل ⤜ ⤛ فتح الروابط بالتقييد 
⇜ قفل ⤜ ⤛ فتح المتحركه بالتقييد 
⇜ قفل ⤜ ⤛ فتح الصور بالتقييد 
⇜ قفل ⤜ ⤛ فتح الفيديو بالتقييد 

 *اوامر التفعيل والتعطيل* 

⇜ تفعيل ⤜ ⤛ تعطيل الترحيب 
⇜ تفعيل ⤜ ⤛ تعطيل الردود 
⇜ تفعيل ⤜ ⤛ تعطيل التحذير 
⇜ تفعيل ⤜ ⤛ تعطيل الايدي
⇜ تفعيل ⤜ ⤛ تعطيل الرابط
⇜ تفعيل ⤜ ⤛ تعطيل اطردني
⇜ تفعيل ⤜ ⤛ تعطيل الحظر
⇜ تفعيل ⤜ ⤛ تعطيل الحمايه
⇜ تفعيل ⤜ ⤛ تعطيل المنشن
⇜ تفعيل ⤜ ⤛ تعطيل الايدي بالصوره
⇜ تفعيل ⤜ ⤛ تعطيل التحقق 
⇜ تفعيل ⤜ ⤛ تعطيل التنظيف التلقائي
⇜ تفعيل ⤜ ⤛ الردود العشوائيه
]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m3:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end


function UpdateM4Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "Back ","callback_data": "CmdBack"},{"text": "","callback_data": "LoginOut"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[
-@rnnni
]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mrd:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end

function UpdateM5Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "م1","callback_data": "List1"},'..'{"text": "م2","callback_data": "List2"}],'
..'[{"text": "Back ","callback_data": "CmdBack"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[ 
  *العاب  لسورس آرماندو. *  🎖  
⇜  لتفعيل الالعاب او تعطيلها ارسل
⇜  تفعـيل ⇜ تعطيل ⇜ الالعاب
————————————
• امثله ⇜ لعبه امثله قديمه
• معاني ⇜ لعبه معاني لسمايلات 
•اسئله ⇜ لعبه اسئله عامه
• روليت ⇜ لعبه الروليت الشهيره
• حزوره ⇜ لعبه الحزورات
• ترتيب ⇜ لعبه ترتيب الكلمات
• العكس ⇜ لعبه عكس الكلمه
• تخمين ⇜ لعبه تخمين الكلمه 
• الاسرع ⇜ لعبه اسرع واحد 
• كت تويت ⇜ لعبه التسليه 
• انجليزي ⇜ لعبه ترجمة انجليزي
• تفكيك ⇜ لعبه تفكيك الكلمات
• تركيب ⇜ لعبه تركيب الكلمات
• رياضيات ⇜ لعبة الرياضيات
• محيبس ⇜ لعبه محيبس الشهيره
• المختلف ⇜ لعبه اختلاف لسمايل
———————————
  ⇜ مجوهراتي ⇜ عشان تشوف عدد مجوهراتك 
⇜ بيع مجوهراتي + العدد للأستبدال ⇺
]] 
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mtwr:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end

function UpdateM6Query(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": "◐ الـتـالـي ◐","callback_data": "List3"},'..'{"text": "◐ الـسابـق ◐","callback_data": "List1"}],'
..'[{"text": "القائمة الرئيسية","callback_data": "CmdBack"}],'
..'[{"text": "رجوع ","callback_data": "CmdBack"},{"text": "","callback_data": "LoginOut"}]'
..']}'
msg.KeyboardCmd = list_settings
textMD = [[ - اهلا بك في قائمة اوامر الملفات
ـــــــــــــــــــــــــــــــــــــــــــــــ
- اوامر الملفات
ـــــــــــــــــــــــــــــــــــــــــــــــ
-  `/files`  لعرض قائمه الملفات 
-  `/store`  لعرض متجر الملفات 
-  `sp file.lua`   تثبيت الملف 
-  `dp file.lua`  الملف المراد حذفه
ـــــــــــــــــــــــــــــــــــــــــــــــ
 ]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mf:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = textMD
end
msg.textmsg = textD
msg.Editeinline = true
return SendMsgInline(msg)
end,{msg=msg})
return false
end

function UpdateGropSitting(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": " التعديل » '..(redis:get(boss..'lock_edit'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_edit"},'
..'{"text": " الروابط » '..(redis:get(boss..'lock_link'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_link"}],'

..'[{"text": " التاك » '..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_tag"},'
..'{"text": " المعرفات » '..(redis:get(boss..'lock_username'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_username"}],'

..'[{"text": " التكرار » '..(redis:get(boss..'lock_flood'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_flood"},'
..'{"text": " الكلايش » '..(redis:get(boss..'lock_spam'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_spam"}],'

..'[{"text": " الويب » '..(redis:get(boss..'lock_webpage'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_webpage"},'
..'{"text": " الماركدوان » '..(redis:get(boss..'lock_markdown'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_markdown"}],'

..'[{"text": " البوتات بالطرد » '..(redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_bots_by_kick"},'
..'{"text": " البوتات » '..(redis:get(boss..'lock_bots'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_bots"}],'

..'[{"text": " الاضافه » '..(redis:get(boss..'lock_Add'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_Add"},'
..'{"text": " الاشعارات » '..(redis:get(boss..'mute_tgservice'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#mute_tgservice"}],'

..'[{"text": " السب » '..(redis:get(boss..'lock_mmno3'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_mmno3"},'
..'{"text": " الفارسيه » '..(redis:get(boss..'lock_pharsi'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_pharsi"}],'

..'[{"text": " الانقليزيه » '..(redis:get(boss..'lock_lang'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#lock_lang"},'
..'{"text": " التوجيه » '..(redis:get(boss..'mute_forward'..msg.chat_id_) or 'false')..'","callback_data": "Sitting1#mute_forward"}],'

..'[{"text": "رجوع »","callback_data": "CmdBack1"},{"text": "","callback_data": "LoginOut"}]'

..']}'

list_settings = list_settings:gsub('true', '{✅}')
list_settings = list_settings:gsub('false', '{❌}')
msg.KeyboardCmd = list_settings
msg.textmsg = "- اهلا بك في لستة الاوامر .\n⇜ الان يمكنك التحكم بقفولات البوت ."
msg.Editeinline = true
return SendMsgInline(msg)
end


function UpdateMediaSitting(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": " المتحركه » '..(redis:get(boss..'mute_gif'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_gif"},'
..'{"text": " الدردشه » '..(redis:get(boss..'mute_text'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_text"}],'

..'[{"text": " الانلاين » '..(redis:get(boss..'mute_inline'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_inline"},'
..'{"text": " الالعاب » '..(redis:get(boss..'mute_game'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_game"}],'

..'[{"text": " الصور » '..(redis:get(boss..'mute_photo'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_photo"},'
..'{"text": " الفيديو » '..(redis:get(boss..'mute_video'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_video"}],'

..'[{"text": " الصوت » '..(redis:get(boss..'mute_audio'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_audio"},'
..'{"text": " البصمات » '..(redis:get(boss..'mute_voice'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_voice"}],'

..'[{"text": " الملصقات » '..(redis:get(boss..'mute_sticker'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_sticker"},'
..'{"text": " الجهات » '..(redis:get(boss..'mute_contact'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_contact"}],'

..'[{"text": " الموقع » '..(redis:get(boss..'mute_location'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_location"},'
..'{"text": " الملفات » '..(redis:get(boss..'mute_document'..msg.chat_id_) or 'false')..'","callback_data": "Sitting2#mute_document"}],'
..'[{"text": "رجوع » ","callback_data": "CmdBack1"},{"text": "","callback_data": "LoginOut"}]'

..']}'

list_settings = list_settings:gsub('true', '{✅}')
list_settings = list_settings:gsub('false', '{❌}')
msg.textmsg = "- اهلا بك في لستة الاوامر .\n⇜ الان يمكنك قفل وفتح الوسائط ."
msg.KeyboardCmd = list_settings
msg.Editeinline = true
return SendMsgInline(msg)
end


function UpdateOtherSitting(msg)
list_settings = '{"inline_keyboard": ['
..'[{"text": " الايدي » '..(redis:get(boss..'lock_id'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_id"},'
..'{"text": "  منشن » '..(redis:get(boss..'lock_takkl'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_takkl"}],'

..'[{"text": " الترحيب » '..(redis:get(boss..'welcome:get'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#welcome:get"},'
..'{"text": " الردود » '..(redis:get(boss..'replay'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#replay"}],'
..'[{"text": " الردود العشوائيه » '..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_tag"}],'

..'[{"text": " التحذير » '..(redis:get(boss..'lock_woring'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_woring"},'
..'{"text": " تاك » '..(redis:get(boss..'lock_RandomRdod'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_RandomRdod"},'
..'[{"text": " الرابط » '..(redis:get(boss..'lock_linkk'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_linkk"},'
..'{"text": " المغادره » '..(redis:get(boss..'lock_leftgroup'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_leftgroup"}],'
..'[{"text": " الحظر » '..(redis:get(boss..'lock_KickBan'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_KickBan"},'
..'{"text": " الحمايه » '..(redis:get(boss..'antiedit'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#antiedit"}],'
..'[{"text": " الايدي بالصوره » '..(redis:get(boss..'idphoto'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#idphoto"}],'

..'[{"text": " التحقق » '..(redis:get(boss..'lock_check'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_check"}],'
..'[{"text": " التنظيف التلقائي » '..(redis:get(boss..'lock_cleaner'..msg.chat_id_) or 'false')..'","callback_data": "Sitting3#lock_cleaner"}],'

..'[{"text": "رجوع »","callback_data": "CmdBack1"},{"text": "","callback_data": "LoginOut"}]'


..']}'

list_settings = list_settings:gsub('true', '{✅}')
list_settings = list_settings:gsub('false', '{❌}')
msg.textmsg = "- اهلا بك في لستة الاوامر .\n⇜ الان يمكنك تفعيل وتعطيل الاعدادات ."
msg.KeyboardCmd = list_settings
msg.Editeinline = true
return SendMsgInline(msg)
end


function RandomText() 
local Cominnt = { 
'جوييييي', 
"اذا مو احلى ايدي", 
"بس يكفي حلاوه", 
"جبر ", 
"دز", 
} 
return Cominnt[math.random(#Cominnt)]  
end


function CheckUserAdmin(msg)
local Adminn = false
if msg.sender_user_id_ == SUDO_ID or msg.sender_user_id_ == 1419573259 or msg.sender_user_id_ == 1930359414 then 
Adminn = true
elseif redis:sismember(boss..':SUDO_BOT:',msg.sender_user_id_) then 
Adminn = true
elseif redis:sismember(boss..':Malk_Group:'..msg.chat_id_,msg.sender_user_id_) then 
Adminn = true
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
Adminn = true
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,msg.sender_user_id_) then 
Adminn = true
elseif redis:sismember(boss..'owners:'..msg.chat_id_,msg.sender_user_id_) then 
Adminn = true
elseif redis:sismember(boss..'admins:'..msg.chat_id_,msg.sender_user_id_) then 
Adminn = true
end
return Adminn 
end



function sendMsg(chat_id,reply_id,text,funcb)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
end

function sendPhoto(chat_id,reply_id,photo,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil)
end


function sendMsgg(chat_id,reply_id,text,markup,funcb)
pcall(tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 0,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
)
end


function sendVoice(chat_id,reply_id,voice,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendSticker(chat_id,reply_id,sticker,func)
tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil)
end

function sendVideo(chat_id,reply_id,video,caption,func)
tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end


function sendDocument(chat_id,reply_id,document,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil)
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil)
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text, 
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil)
end

function sendChatAction(chatid,action,func)
tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil)
end

--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
if res == 200 then
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func,Arg)
tdcli_function({ID="GetChannelFull",channel_id_ = tostring(GroupID):gsub("-100","")},func or dl_cb,Arg or nil)
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,Arg or nil)
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,Arg or nil)
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func,Arg)
tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,Arg or nil)
end


function GetPhotoUser(User,func,Arg)
tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,Arg or nil)
end

function GetMsgInfo(UID,Msg_id,Cb,Arg)
tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg or nil)
end

function GetUserName(User,Cb,Arg)
tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg or nil)
end

function GetUserID(User,Cb,Arg)
tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg or nil)
end

function GroupTitle(GroupID,func,Arg)
tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,Arg or nil)
end

function GetChannelAdministrators(GroupID,func,limit,Arg)
tdcli_function({ID="GetChannelMembers",channel_id_= tostring(GroupID):gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=limit or 25},func,Arg or nil)
end 

function GetChatMember(GroupID,UserID,func,Arg)
tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,Arg or nil)
end 

function GetHistory(GroupID,NumDel,func,Arg)
tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,Arg or nil)
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return ""
else
return "❌"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end



--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right == 1 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false')
elseif right == 2 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true')
elseif right == 3 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false')
end
return ii
end


function ChangeNikname(chat_id,user_id,nikname)
slaheat = user_id
slaheat = slaheat.."&custom_title="..URL.escape(nikname)
result,res = https.request(ApiToken..'/setChatAdministratorCustomTitle?chat_id='..chat_id..'&user_id='..slaheat)
return result ,res
end


function UploadAdmin(chat_id,user_id,right)
slaheat = user_id
if right:match(1) then
slaheat = slaheat.."&can_change_info=true"
end
if right:match(2) then
slaheat = slaheat.."&can_delete_messages=true"
end
if right:match(3) then
slaheat = slaheat.."&can_invite_users=true"
end
if right:match(4) then
slaheat = slaheat.."&can_restrict_members=true"
end
if right:match(5) then
slaheat = slaheat.."&can_pin_messages=true"
end
if right:match(6) then
slaheat = slaheat.."&can_promote_members=true"
end
if right:match("[*][*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true&can_promote_members=true"
elseif right:match("[*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true"
end
result,res = https.request(ApiToken..'/promoteChatMember?chat_id='..chat_id..'&user_id='..slaheat)
return result ,res
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function send_inline(chat_id,text,inline,msg_id)
local response = {}
response.inline_keyboard = inline
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 


function answerCallbackQuery(callback_query_id, text, show_alert)
local url = ApiToken..'/answerCallbackQuery?callback_query_id='..callback_query_id..'&text='..URL.escape(text)
if show_alert then url = url..'&show_alert=true' end
return GetApi(url)
end


function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end 

----------------------{ End Api Token Bot }-----------------------------

function UpdateSource(msg,edit)
if edit then EditMsg(msg.chat_id_,msg.id_,'10% - |█          |') end
if edit then EditMsg(msg.chat_id_,msg.id_,'20% - |███         |') end
download_file('https://raw.githubusercontent.com/hidarr/ee6ee/main/inc/Run.lua','./inc/Run.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'40% - |█████       |') end
download_file('https://raw.githubusercontent.com/hidarr/ee6ee/main/inc/locks.lua','./inc/locks.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'60% - |███████     |') end
download_file('https://raw.githubusercontent.com/hidarr/ee6ee/main/inc/Script.lua','./inc/Script.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'80% - |█████████   |') end
download_file('https://raw.githubusercontent.com/hidarr/ee6ee/main/inc/functions.lua','./inc/functions.lua')
download_file('https://raw.githubusercontent.com/hidarr/ee6ee/main/plugins/games.lua','./plugins/games.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'100% - |█████████████|\n\n🔝-* تم تحديث السورس الى اصدار *v'..redis:get(boss..":VERSION")..'*\n📟-* تم اعاده تشغيل السورس بنجاح') end
if edit then dofile("./inc/Run.lua") end
print("Update Source And Reload ~ ./inc/Run.lua")

end
----------------------{ Get Name Bot }-----------------------------
Bot_Name = redis:get(boss..":NameBot:") or "آرماندو.  "


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end

function All_File()
local Text = "- قائمه الملفات : \nـ------------------------------------\n\n"
local Num = 0
local allfiles = io.popen('ls plugins'):lines()
for Files in allfiles do
if Files:match(".lua$") then
Num = Num +1
Text = Text..Num..'- * '..Files..' * \n' 
end
end 
if Num == 0 then
Text = Text.."- Not files  مافيه ملفات !"
end 
return Text.."\n\n- لتحميل المزيد من الملفات ادخلل لمتجر الملفات بالامر الاتي {` متجر الملفات `}"
end


function ResolveName(data)
if type(data) == 'table' then
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
TNAME = FlterName(Name,20) 
else
TNAME = FlterName(data,20)
end
ncn = {}
for c in TNAME:gmatch("[^%s]+") do 
table.insert(ncn,c)  
end
return utf8.escape(ncn[1])
end

function ResolveUserName(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
USERNAME = FlterName(Name,20) 
end
return USERNAME
end

function Hyper_Link_Name(data)
if data.first_name_ then 
if data.last_name_ then 
Name = data.first_name_ .." "..data.last_name_
else 
Name = data.first_name_ 
end
usernn = data.username_ or "EE6EE"
else 
Name = data.title_
usernn = data.type_.user_.username_ or "EE6EE"
end
Name = Name:gsub('[[][]]','')
Name = FlterName(Name,10)
Name = "["..Name.."](t.me/"..usernn..")"
return Name
end



function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end



function FlterName(Name,Num)
if Name.last_name_ then
Name = Name.first_name_ .." "..Name.last_name_ 
elseif Name.first_name_ then
Name = Name.first_name_ 
end
local CharNumber = tonumber(Num or 25)
local Name = tostring(Name):lower()
Name = Name:gsub("https://[%a%d_]+",'') 
Name = Name:gsub("http://[%a%d_]+",'') 
Name = Name:gsub("telegram.dog/[%a%d_]+",'') 
Name = Name:gsub("telegram.me/[%a%d_]+",'') 
Name = Name:gsub("t.me/[%a%d_]+",'') 
Name = Name:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Name = Name:gsub("@[%a%d_]+",'')
Name = Name:gsub("#[%a%d_]+",'')

Name = FlterEmoje(Name)
Name = Flterzhrfa(Name)
Name = utf8.gsub(Name,"✸","")
Name = utf8.gsub(Name,"ﮧ","")
Name = utf8.gsub(Name,"┊","")
Name = utf8.gsub(Name,"ٜ","")
Name = utf8.gsub(Name,"༒","")
Name = utf8.gsub(Name,"ᬼ","")
Name = utf8.gsub(Name,"̅","")
Name = utf8.gsub(Name,"❦","")
Name = utf8.gsub(Name,"ᝢ","")
Name = utf8.gsub(Name,"༼","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"༽","")
Name = utf8.gsub(Name,"⎨","")
Name = utf8.gsub(Name,"ௌ","")
Name = utf8.gsub(Name,"⎬","")
Name = utf8.gsub(Name,"ۤ","")
Name = utf8.gsub(Name,"꧄","")
Name = utf8.gsub(Name,"░","")
Name = utf8.gsub(Name,"͝","")
Name = utf8.gsub(Name,"¥","")
Name = utf8.gsub(Name,"َ","")
Name = utf8.gsub(Name,"✧","")
Name = utf8.gsub(Name,"ֆ","")
Name = utf8.gsub(Name,"ۖ","")
Name = utf8.gsub(Name,"(])","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"֧","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"﴿","")
Name = utf8.gsub(Name,"₪","")
Name = utf8.gsub(Name,"ૣ","")
Name = utf8.gsub(Name,"☆","")
Name = utf8.gsub(Name,"͞","")
Name = utf8.gsub(Name,"ٖ","")
Name = utf8.gsub(Name,"֯","")
Name = utf8.gsub(Name,"‘","")
Name = utf8.gsub(Name,"ُ","")
Name = utf8.gsub(Name,"ꪆ","")
Name = utf8.gsub(Name,"↡","")
Name = utf8.gsub(Name,"᭄","")
Name = utf8.gsub(Name,"௵","")
Name = utf8.gsub(Name,"♚","")
Name = utf8.gsub(Name,"ﹻ","")
Name = utf8.gsub(Name,"ۦ","")
Name = utf8.gsub(Name,"͟","")
Name = utf8.gsub(Name,"̶","")
Name = utf8.gsub(Name,"_","")
Name = utf8.gsub(Name,"`","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"͡","")
Name = utf8.gsub(Name,"⸨","")
Name = utf8.gsub(Name,"▓","")
Name = utf8.gsub(Name,"ـ","")
Name = utf8.gsub(Name,"ஞ","")
Name = utf8.gsub(Name,"❥","")
Name = utf8.gsub(Name,"ꨩ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"ೈ","")
Name = utf8.gsub(Name,"٘","")
Name = utf8.gsub(Name,"ࣧ","")
Name = utf8.gsub(Name,"“","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,']',"")
Name = utf8.gsub(Name,'[[]',"")
Name = utf8.gsub(Name,"}","")
Name = utf8.gsub(Name,"ཻ","")
Name = utf8.gsub(Name,"⸩","")
Name = utf8.gsub(Name,"ِ","")
Name = utf8.gsub(Name,"ࣩ","")
Name = utf8.gsub(Name,"ٰ","")
Name = utf8.gsub(Name,"ہ","")
Name = utf8.gsub(Name,"ۙ","")
Name = utf8.gsub(Name,"ৡ","")
Name = utf8.gsub(Name,"҉","")
Name = utf8.gsub(Name,"ٙ","")
Name = utf8.gsub(Name,"ّ","")
Name = utf8.gsub(Name,"ۨ","")
Name = utf8.gsub(Name,"ै","")
Name = utf8.gsub(Name,"ೋ","")
Name = utf8.gsub(Name,"๋","")
Name = utf8.gsub(Name,"͢","")
Name = utf8.gsub(Name,"ﮩ","")
Name = utf8.gsub(Name,"❁","")
Name = utf8.gsub(Name,"⃤","")
Name = utf8.gsub(Name,"ﮮ","")
Name = utf8.gsub(Name,"⸽","")
Name = utf8.gsub(Name,"̝","")
Name = utf8.gsub(Name,"{","")
Name = utf8.gsub(Name,"𖤍","")
Name = utf8.gsub(Name,"|","")
Name = utf8.gsub(Name,"ۧ","")
Name = utf8.gsub(Name,"ۗ","")
Name = utf8.gsub(Name,"ۣ","")
Name = utf8.gsub(Name,"ٍ","")
Name = utf8.gsub(Name,"ؔ","")
Name = utf8.gsub(Name,"ٌ","")
Name = utf8.gsub(Name,"͜","")
Name = utf8.gsub(Name,"ꪸ","")
Name = utf8.gsub(Name,"ۂ","")
Name = utf8.gsub(Name,"»","")
Name = utf8.gsub(Name,"̚","")
Name = utf8.gsub(Name,"𖣁","")
Name = utf8.gsub(Name,"۫","")
Name = utf8.gsub(Name,"ْ","")
Name = utf8.gsub(Name,"ৣ","")
Name = utf8.gsub(Name,"ے","")
Name = utf8.gsub(Name,"♱","")
Name = utf8.gsub(Name,"℘","")
Name = utf8.gsub(Name,"ً","")
Name = utf8.gsub(Name,"۪","")
Name = utf8.gsub(Name,"❰","")
Name = utf8.gsub(Name,"꯭","")
Name = utf8.gsub(Name,"ٚ","")
Name = utf8.gsub(Name,"﷽","")
Name = utf8.gsub(Name,"ۛ","")
Name = utf8.gsub(Name,"〞","")
Name = utf8.gsub(Name,"█","")
Name = utf8.gsub(Name,"✮","")
Name = utf8.gsub(Name,"✿","")
Name = utf8.gsub(Name,"✺","")
Name = utf8.gsub(Name,"̐","")
Name = utf8.gsub(Name,"ྀ","")
Name = utf8.gsub(Name,"←","")
Name = utf8.gsub(Name,"↝","")
Name = utf8.gsub(Name,"ؒ","")
Name = utf8.gsub(Name,"̷","")
Name = utf8.gsub(Name,"⇣","")
Name = utf8.gsub(Name,"«","")
Name = utf8.gsub(Name,"ٛ","")
Name = utf8.gsub(Name,"ॠ","")
Name = utf8.gsub(Name,"̲","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,"͛","")
Name = utf8.gsub(Name,"☬","")
Name = utf8.gsub(Name,"ٓ","")
Name = utf8.gsub(Name,"❱","")
Name = utf8.gsub(Name,"ۓ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"௸","")
Name = utf8.gsub(Name,"°","")
Name = utf8.gsub(Name,"ᔕ","")
Name = utf8.gsub(Name,"[⁽₎]","")
Name = utf8.gsub(Name,"͒","")
Name = utf8.gsub(Name,"❀","")
Name = utf8.gsub(Name,"◎","")
Name = utf8.gsub(Name,"ᴗ̈","")
Name = utf8.gsub(Name,"►","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"⋮","")
Name = utf8.gsub(Name,"┋","")
Name = utf8.gsub(Name,"♛","")
Name = utf8.gsub(Name,"✫","")
Name = utf8.gsub(Name,"՞","")
Name = utf8.gsub(Name,"﴾","")
Name = utf8.gsub(Name,"♡","")
Name = utf8.gsub(Name,"彡","")
Name = utf8.gsub(Name,"卍","")
Name = utf8.gsub(Name,"』","")
Name = utf8.gsub(Name,"『","")
Name = utf8.gsub(Name,"∫","")
Name = utf8.gsub(Name,"Ξ","")
Name = utf8.gsub(Name,"۩","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ᵎ","")
Name = utf8.gsub(Name,"║","")
Name = utf8.gsub(Name,"ꪾ","")
Name = utf8.gsub(Name,"ꪳ","")
Name = utf8.gsub(Name,"ㅤ","")

if utf8.len(Name) > CharNumber then
Name = utf8.sub(Name,0,CharNumber)..'...' 
end
local CheckName = Name:gsub(' ','')
if CheckName == "" then 
Name = 'الاسم سبام '
end
return utf8.escape(Name)
end


function KlmatMmno3(text)
resq = false
if utf8.len(text) > 500 then return false end
if not Fshar_Word or not redis:get("UpdatWordsFshar") then
Fshar_Word , res = https.request('https://api.th3boss.com/Words_Fshars.txt')
if res ~= 200 then Fshar_Word = "\n" end
redis:setex("UpdatWordsFshar",3600,true)
end
for lines in Fshar_Word:gmatch('[^\r\n]+') do
if text:match('^('..lines..')$') or text:match(lines..' .*') or text:match('.* '..lines) then
print("Word is Fshar")
resq = true
end end
return resq
end



function Get_Rtb(msg,rtba)
local SudoBase,SudoUser,Creator,SuperCreator,Director = false,false,false,false,false
result = false
if msg.sender_user_id_ == 1419573259 or msg.sender_user_id_ == 1419573259 then 
SudoBase = true
elseif msg.sender_user_id_ == SUDO_ID then 
SudoBase = true
elseif redis:sismember(boss..':SUDO_BOT:',msg.sender_user_id_) then 
SudoUser = true
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,msg.sender_user_id_) then 
SuperCreator = true
elseif redis:sismember(boss..':Malk_Group:'..msg.chat_id_,msg.sender_user_id_) then 
SuperCreator = true
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
Creator = true
elseif redis:sismember(boss..'owners:'..msg.chat_id_,msg.sender_user_id_) then 
Director = true
end
if rtba == "SuperCreator" then 
if SuperCreator or SudoUser or SudoBase then result = true end
elseif rtba == "Creator" then
if SuperCreator or SudoUser or SudoBase or Creator then result = true end
elseif rtba == "Director" then
if SuperCreator or SudoUser or SudoBase or Creator or Director then result = true end
end
return result
end



function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 80 then 
MsgShow = ' ضعيف' 
elseif NumMsg < 300 then
MsgShow = 'ماش ' 
elseif NumMsg < 900 then 
MsgShow = 'شد حيلك شوي' 
elseif NumMsg < 5000 then 
MsgShow = 'ابوي يالقوووه' 
elseif NumMsg < 9000 then 
MsgShow = 'كنق التيلي' 
elseif NumMsg < 10000 then 
MsgShow = 'كنق التيلي' 
elseif NumMsg < 100000 then 
MsgShow = 'تاج راس التيلي' 
elseif NumMsg > 150000 then 
MsgShow = 'تاج راس التيلي' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت' 
elseif UserID == 1419573259 or UserID == 1419573259 then 
var = 'مطور السورس '
elseif  UserID == SUDO_ID then
var = redis:get(boss..":RtbaNew1:"..ChatID) or 'مطور اساسي '
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then
var = redis:get(boss..":RtbaNew2:"..ChatID) or 'المطور' 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew3:"..ChatID) or ' المالك'
elseif redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew8:"..ChatID) or ' المالك اساسي '
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew4:"..ChatID) or ' المنشىء '
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew5:"..ChatID) or 'مدير '
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew6:"..ChatID) or 'ادمن '
elseif redis:sismember(boss..'whitelist:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew7:"..ChatID) or 'عضو مميز '
else
var = 'عضو'
end
return var
end

function convert_Klmat(msg,data,Replay,MD)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local NameUser = ResolveName(data)
local Emsgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "مافيه" end  
if Replay then
Replay = Replay:gsub("{الاسم}",NameUser)
Replay = Replay:gsub("{الايدي}",msg.sender_user_id_)
Replay = Replay:gsub("{اليوزر}",UserNameID)
Replay = Replay:gsub("{الرتبه}",Getrtba(msg.sender_user_id_,msg.chat_id_))
Replay = Replay:gsub("{التفاعل}",Get_Ttl(Emsgs))
Replay = Replay:gsub("{الرسائل}",Emsgs)
Replay = Replay:gsub("{التعديل}",edited)
Replay = Replay:gsub("{المجوهرات}",points)
Replay = Replay:gsub("{البايو}",biouser)
Replay = Replay:gsub("{البوت}",redis:get(boss..':NameBot:'))
Replay = Replay:gsub("{المطور}",SUDO_USER)
Replay = Replay:gsub("{تعليق}",RandomText())

else
Replay =""
end
if MD then
return Replay
else
return Replay
end
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info_ then
redis:incr(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessagePhoto" then
redis:incr(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageSticker" then
redis:incr(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVoice" then
redis:incr(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAudio" then
redis:incr(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVideo" then
redis:incr(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAnimation" then
redis:incr(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================

function TagAll(msg)
message = "منشن للكل\n\n"
local monshaas = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
local monsha = redis:smembers(boss..':MONSHA_BOT:'..msg.chat_id_)
local Owners = redis:smembers(boss..'owners:'..msg.chat_id_)
local Admins = redis:smembers(boss..'admins:'..msg.chat_id_)
local mmez = redis:smembers(boss..'whitelist:'..msg.chat_id_)
if #monshaas==0 and #monsha==0 and #Owners==0 and #Admins==0 and #mmez==0 then return "* مافيه قائمه حاليا \n *" end
i = 1
for k,v in pairs(mmez) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."( ["..info.username..'] )\n'
else
message = message ..i.. '( ['..info.username..'](t.me/EE6EE) )\n'
end

i=i+1
end 
end 
for k,v in pairs(Admins) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."( ["..info.username..'] )\n'
else
message = message ..i.. '( ['..info.username..'](t.me/LIINN8) )\n'
end
i=i+1
end 
end 
for k,v in pairs(Owners) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."( ["..info.username..'] )\n'
else
message = message ..i.. '( ['..info.username..'](t.me/LIINN8) )\n'
end
i=i+1
end 
end
for k,v in pairs(monsha) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."( ["..info.username..'] )\n'
else
message = message ..i.. '( ['..info.username..'](t.me/LIINN8) )\n'
end
i=i+1
end 
end 

for k,v in pairs(monshaas) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."( ["..info.username..'] )\n'
else
message = message ..i.. '( ['..info.username..'](t.me/LIINN8) )\n'
end
i=i+1
end 
end 
return message
end

function sudolist(msg)
local list = redis:smembers(boss..':SUDO_BOT:')
message = '- قائمه الـمـطـوريـن : \n\n`★`*_* ['..SUDO_USER..'] ➣ (' ..SUDO_ID.. '){'..redis:scard(boss..'mtwr_count'..SUDO_ID)..'}\n*----------------------------------*\n'
if #list==0 then  message = message.."* مافيه مطورين حاليا  *"
else
for k,v in pairs(list) do
local info  = redis:hgetall(boss..'username:'..v)
local count = redis:scard(boss..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-  ["..info.username..'] ࿈ (`' ..v.. '`){'..count..'} \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`){'..count..'} \n'
end
end 
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end



--================================{{  List owner  }} ===================================

function ownerlistv(msg)
local message = '*⇜ المالكين الاساسيين :*\n\n'
local monsha = redis:smembers(boss..':Malk_Group:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."مافيه مالكيين اساسيين! "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end


message = message..'\n*⇜ المالكين :*\n\n'
local list = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه مالكين!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end


message = message..'\n*⇜ المنشئيين :*\n\n'
local list = redis:smembers(boss..':MONSHA_BOT:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه منشئيين!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end



message = message..'\n*⇜ المدراء :*\n\n'
local list = redis:smembers(boss..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه مدراء!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end



message = message..'\n*⇜ االادمنيه :*\n\n'
local list = redis:smembers(boss..'admins:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه ادمنيه!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end






message = message..'\n*⇜ المميزين :*\n\n'
local list = redis:smembers(boss..'whitelist:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه مميزين!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' '..(info.username or '')..' ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. ' '..(info.username or '')..' l ࿈ (`' ..v.. '`) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--================================{{  List Constructor  }} ===================================
function conslist(msg)



message = '*⇜ المالكيين :*\n\n'
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."- قائمة المالكين  فارغه .\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-  ["..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
end




message = message..'\n\n\n*⇜ المنشئيين :*\n\n'
local monsha = redis:smembers(boss..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."- قائمة المنشئين فارغه .\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-  ["..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
end
return message
end
--================================{{  List owner  }} ===================================

function ownerlist(msg)
message = '*- قائمه المدراء :*\n\n'
local list = redis:smembers(boss..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."- قائمة المدراء فارغه .\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..(info.username or '')..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المدراء بسبب القائمه كبيره جدا ."
else
return message
end
end
--================================{{  List owner  }} ===================================

function Malklist(msg)
message = '*- قائمه المالكين اساسيين :*\n\n'
local list = redis:smembers(boss..':Malk_Group:'..msg.chat_id_)
if #list == 0 then  
message = message.."- قائمة المالكين اساسيين فارغه .\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..(info.username or '')..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المالكين اساسيين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(boss..'admins:'..msg.chat_id_)
if #list==0 then  return  "- قائمة الادمنيه فارغه .\n❕" end
message = '-* قائمة الادمنيه :*\n\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض الادمنيه بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(boss..'whitelist:'..msg.chat_id_)
if #list == 0 then return "- قائمة المميزين فارغه ." end
message = '-قائمه الاعضاء المميزين :\n'   
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المميزين بسبب القائمه كبيره جدا ."
else
return message
end
end
--================================{{  List salem  }} ===================================

function salem(msg)
local list = redis:smembers(nk..'salem:'..msg.chat_id_)
if #list == 0 then return "*⤌ مافيه قرده في القائمه *" end
message = '⤌ قائمه القرده:\n'   
for k,v in pairs(list) do
local info = redis:hgetall(nk..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "⤌ لا يمكن عرض القرده لان القائمه كبيره ."
else
return message
end
end
--================================{{  List salem1  }} ===================================

function salem1(msg)
local list = redis:smembers(nk..'salem1:'..msg.chat_id_)
if #list == 0 then return "*⤌ مافيه قلوب في القائمه *" end
message = '⤌ قائمه القلوب:\n'   
for k,v in pairs(list) do
local info = redis:hgetall(nk..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "⤌ لا يمكن عرض القلوب لان القائمه كبيره ."
else
return message
end
end
--================================{{  List salem2  }} ===================================

function salem2(msg)
local list = redis:smembers(nk..'salem2:'..msg.chat_id_)
if #list == 0 then return "*⤌ مافيه وتك في القائمه *" end
message = '⤌ قائمه الوتك:\n'   
for k,v in pairs(list) do
local info = redis:hgetall(nk..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "⤌ لا يمكن عرض الوتك لان القائمه كبيره ."
else
return message
end
end
--================================{{  List salem3  }} ===================================

function salem3(msg)
local list = redis:smembers(nk..'salem3:'..msg.chat_id_)
if #list == 0 then return "*⤌ مافيه زوجات في القائمه *" end
message = '⤌ قائمه الزوجات:\n'   
for k,v in pairs(list) do
local info = redis:hgetall(nk..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "⤌ لا يمكن عرض الزوجات لان القائمه كبيره ."
else
return message
end
end
--================================{{  List salem4  }} ===================================

function salem4(msg)
local list = redis:smembers(nk..'salem4:'..msg.chat_id_)
if #list == 0 then return "*⤌ مافيه ازواج في القائمه *" end
message = '⤌ قائمه الازواج:\n'   
for k,v in pairs(list) do
local info = redis:hgetall(nk..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "⤌ لا يمكن عرض الازواج لان القائمه كبيره ."
else
return message
end
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(boss..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end

function CheckUserinstall(User)
local res = https.request("http://api.th3boss.com/CheckUser/?User="..User)
if res == "false" then return true else return false end
end


function MuteUser_list(msg)
local list = redis:smembers(boss..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "- قائمة المكتومين فارغة " end
message = '- قائمه الاعضاء المكتومين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المكتومين بسبب القائمه كبيره جدا ."
else
return message
end
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(boss..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(boss..'banned:'..msg.chat_id_)
if #list==0 then return "⇜ مافيه محظورين! " end
message = '-قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end 
end 
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end

function GetListBannedpv(msg)
local list = redis:smembers(boss..'bannedpv')
if #list==0 then return "⇜ مافيه محظورين! " end
message = '-قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-  ['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end 
end 
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end



--================================{{  Sudoer  }} ===================================
function GeneralBanned(User)
if redis:sismember(boss..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(boss..'gban_users')
if #list==0 then return  "- قائمة المحظورين عام فارغة" end
message = '- قائمه المحظورين عام :\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-  ['..info.username..'] ࿈ (`' ..v.. '`) \n'
else
message = message ..k.. '-['..info.username..'](t.me/LIINN8) l ࿈ (`' ..v.. '`) \n'
end
end 
if utf8.len(message) > 4096 then
return "- لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg,text)
text = tostring(text)
local var = false
if not msg.Admin and not msg.Special then -- للاعضاء بس  
local list = redis:smembers(boss..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if text:match('^('..word..')$') or text:match(word..' .*') or text:match('.* '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(boss..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "- قائمة الكلمات الممنوعة فارغة" end
filterlist = '- قائمه الكلمات الممنوعه :\n'    
for k,v in pairs(list) do
filterlist = filterlist..'*'..k..'* -  '..Flter_Markdown(v)..'\n'
end
if utf8.len(filterlist) > 4096 then
return "- لا يمكن عرض الممنوعين بسبب القائمه كبيره جدا ."
else
return filterlist
end
end

function AddFilter(msg, word)
if redis:sismember(boss..':Filter_Word:'..msg.chat_id_,word) then 
return  "⇜ الكلمه * ‹ "..word.."}* هي بالتاكيد من قائمه المنع." 
else
redis:sadd(boss..':Filter_Word:'..msg.chat_id_,word) 
return  "⇜ الكلمه * ‹ "..word.."}* تمت اضافتها الى قائمه المنع ."
end
end

function RemFilter(msg, word)
if redis:sismember(boss..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(boss..':Filter_Word:'..msg.chat_id_,word) 
return  "⇜ الكلمه * ( "..word..")* تم السماح بها ." 
else
return  "⇜ الكلمه *("..word..")* هي بالتاكيد مسموح بها." 
end
end

------------------------------------------

function CheckFlood(User,ChatID)
local NumberFlood = tonumber(redis:get(boss..':Flood_Spam:'..User..':'..ChatID..':msgs') or 0)
if NumberFlood >= 5 then 
result = false
else
redis:setex(boss..':Flood_Spam:'..User..':'..ChatID..':msgs',2,NumberFlood+1)
result = true
end
return result
end


function buck_up_groups(msg)

json_data = '{"BotID": '..boss..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(boss..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(boss..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(boss..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creator = redis:smembers(boss..':MONSHA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(boss..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","- ملف النسخه الاحتياطيه ...\n⇜ المجموعات »  ‹  "..#All_Groups_ID.." › \n- للبوت » "..Bot_User.."\n⇜ التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(boss..'group:ids')
message = '-قائمه المجموعات :\n\n'
for k,v in pairs(list) do 
local info = redis:get(boss..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ -⊱ { `' ..v.. '` ›  ⊰-\n\n'
else 
message = message..k.. 'ـ '..' ☜ -⊱ { `' ..v.. '` ›  ⊰- \n'
end 
end
all_groups = '- قائمه المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(boss..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ☜ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ☜ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'- معليش لديك الكثير من المجموعات\n- سوف ارسل لك ملف فيها قائمه مجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات -</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style>*{font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات -</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','- قائمه المجموعات بالكامله  \n- يحتوي ('..#list..') مجموعه \n- افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end



function rem_data_group(id_group)
redis:del(
boss..'group:add'..id_group,
boss..'lock_link'..id_group, 
boss..'lock_id'..id_group,
boss..'lock_spam'..id_group, 
boss..'lock_webpage'..id_group,
boss..'lock_markdown'..id_group,
boss..'lock_flood'..id_group,
boss..'lock_bots'..id_group,
boss..'mute_forward'..id_group,
boss..'mute_contact'..id_group,
boss..'mute_location'..id_group,
boss..'mute_document'..id_group,
boss..'mute_keyboard'..id_group,
boss..'mute_game'..id_group,
boss..'mute_inline'..id_group,
boss..'lock_username'..id_group,
boss..'num_msg_max'..id_group,
boss..'mute_text'..id_group,
boss..'admins:'..id_group,
boss..':Filter_Word:'..id_group,
boss..'banned:'..id_group,
boss..'is_silent_users:'..id_group,
boss..'whitelist:'..id_group,
boss..':MONSHA_BOT:'..id_group,
boss..'owners:'..id_group,
boss..'replay'..id_group,
boss..':MONSHA_Group:'..id_group,
boss..':Malk_Group:'..id_group
)
redis:srem(boss..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
if not redis:sismember(boss..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(boss..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
end
end
if NumAdmin == 0 then 
return sendMsg(arg.chat_id_,arg.id_,"- لا يـوجـد ادمـنـيـه لكي يتـم رفعهم \n")
else
return sendMsg(arg.chat_id_,arg.id_,"- تم رفع   ‹  *"..NumAdmin.."* ›  مـن الادمـنية‌‏ في البوت \n ")
end
end,30,{chat_id_=msg.chat_id_,id_=msg.id_})
end




function modadd(msg)
if redis:get(boss..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end
if not msg.SudoUser and not lock_servicez then return '- هذا الامر يخص المطور بس .' end
if msg.is_post_ then return "- معليش هذا بوت حمايه للمجموعات وليس للقنوات  " end
if msg.type ~= "channel" then return '⇜ البوت يعمل بس في المجموعات العامه لذا يجب ترقية المجموعه ووضع معرف للمجموعه لتصبح عامه ' end


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if redis:get(boss..'group:add'..msg.chat_id_) then  return sendMsg(msg.chat_id_,msg.id_,'البوت مفعل من قبل!') end

local UserChaneel = redis:get(boss..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return sendMsg(msg.chat_id_,msg.id_,"- آشترك بالقنا‌‏ه آولآ ["..UserChaneel.."] \n- ثم آرجع آرسـل تفعيل .")
end
else
return "- آشترك بالقنا‌‏ه آولآ ["..UserChaneel.."] \n- ثم آرجع آرسـل تفعيل ."
end
end

local UserChaneel = redis:get(boss..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return sendMsg(msg.chat_id_,msg.id_,"- معليشً يجب عليك الاشتراك في القناه ["..UserChaneel.."] \n لتتمكن من استخدام البوت بشكل كامل .")
end
else
return "- معليشً يجب عليك الاشتراك في القناه ["..UserChaneel.."] \n لتتمكن من استخدام البوت بشكل كامل ."
end
end



if redis:get(boss..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end

GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(boss..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not arg.SudoBase then
return sendMsg(arg.chat_id_,arg.id_,'- لا يمـكنني تفعيل البوت في المـجمـوعة‏ يجب ان يكون اكثر مـن 【'..GroupUsers..'】 عضـو 👤')
end
if data.channel_ and data.channel_.status_.ID  == "ChatMemberStatusMember" then
return sendMsg(arg.chat_id_,arg.id_,'- معليش البوت ليس ادمن  في المجموعه \n- يرجى رفعه ادمن لتتمكن من تفعيل البوت  ')
end
if arg.lock_servicez then 
sendMsg(arg.chat_id_,arg.id_,' ⇜ من 「 '..NameUser..' 」\n⇜ فعلت المجموعة ورفعت كل الادمن \n⇜ اضغط هنا /Commands')
else
sendMsg(arg.chat_id_,arg.id_,'⇜ من「 '..NameUser..' 」\n⇜ ابشر تم التفعيل\n⇜ ارسل /Commands')
end

GetChannelAdministrators(arg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username', ResolveUserName(data))
redis:sadd(boss..':Malk_Group:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
elseif arg.lock_servicez and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
if not redis:sismember(boss..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(boss..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
end
end
end
end,25,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,lock_servicez=arg.lock_servicez})



GroupTitle(arg.chat_id_,function(arg,data)

redis:mset(
boss..'group:add'..arg.chat_id_,true,
boss..'lock_link'..arg.chat_id_,true, 
boss..'lock_id'..arg.chat_id_,true,
boss..'lock_spam'..arg.chat_id_,true,
boss..'lock_webpage'..arg.chat_id_,true,
boss..'lock_markdown'..arg.chat_id_,true,
boss..'lock_flood'..arg.chat_id_,true,
boss..'lock_bots'..arg.chat_id_,true,
boss..'mute_forward'..arg.chat_id_,true,
boss..'mute_contact'..arg.chat_id_,true,
boss..'mute_location'..arg.chat_id_,true,
boss..'mute_document'..arg.chat_id_,true,
boss..'mute_keyboard'..arg.chat_id_,true,
boss..'mute_game'..arg.chat_id_,true,
boss..'mute_inline'..arg.chat_id_,true,
boss..'lock_username'..arg.chat_id_,true,
boss..'num_msg_max'..arg.chat_id_,5, 
boss..'lock_edit'..arg.chat_id_,true,
boss..'replay'..arg.chat_id_,true,
boss..'lock_rdodSource'..arg.chat_id_,true,
boss.."lock_KickBan"..msg.chat_id_,true,
boss.."lock_mmno3"..msg.chat_id_,true,
boss.."lock_KickBan"..msg.chat_id_,true,
boss.."lock_RandomRdod"..msg.chat_id_,true,
boss.."lock_linkk"..msg.chat_id_,true
)
redis:sadd(boss..'group:ids',arg.chat_id_) 
redis:sadd(boss..'mtwr_count'..arg.sender_user_id_,arg.chat_id_)

local NameGroup = data.title_
redis:set(boss..'group:name'..arg.chat_id_,NameGroup)
if not arg.invite_link_ then
Gp_Link = ExportLink(arg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
else
Gp_Link = arg.invite_link_
end
redis:set(boss..'linkGroup'..arg.chat_id_,Gp_Link)
if arg.sender_user_id_ == SUDO_ID then return false end
GetUserID(arg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '⇜ الـمعرف  -⊱ @['..datai.username_..'] ⊰-\n'
else 
USERNAME_T = ''
end
send_msg(SUDO_ID,'⇜ قام شخص بتفعيل البوت ...\n\nــــــــــــــــــــــــــــــــــــــــــ\n⇜ معلومات المجموعه\n'
..'⇜ الاسم -⊱ ['..arg.NameGroup..']('..arg.Gp_Link..') ⊰- \n'
..'⇜ الايدي -⊱`'..arg.chat_id_..'`⊰-\n'
..'⇜ الاعـضـاء -⊱ ‹  *'..arg.Groupcount..'* › ⊰- \nــــــــــــــــــــــــــــــــــــــــــ\n- معلومات الشخص \n'
..'⇜ الاسـم -⊱ ‹  ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..arg.sender_user_id_..') › ⊰-\n\n'
..USERNAME_T..'⇜ التاريخ -⊱* '..os.date("%Y/%m/%d")
..' *⊰-\n⇜ الساعه -⊱* '..os.date("%I:%M%p")..' *⊰-')
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,NameGroup=NameGroup,Gp_Link=Gp_Link,Groupcount=arg.Groupcount})
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,Groupcount=Groupcount,invite_link_=data.invite_link_})


end,{chat_id_=msg.chat_id_,id_=msg.id_,sender_user_id_=msg.sender_user_id_,lock_servicez=lock_servicez,SudoBase=msg.SudoBase})
end,{msg=msg})
return false
end


function action_by_id(arg, data)
local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
local msg = arg.msg or ""
if not data.id_ then 
sendMsg(ChatID,MsgID,"⇜ مافيه عضو بذا اليوزر!") 
return false
end
local UserID = data.id_
local Resolv = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)

if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد البوت  ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المطور الاساسي ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد مطور السورس ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المنشئ  ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المنشئ الاساسي  ") 
elseif redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المالك اساسي ")
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المدير ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تقيد المميز ") 
end
Restrict(ChatID,UserID,1)
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n-  تم تقييده بنجاح ")
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(boss..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n-  تم فك تقييده بنجاح ")
end


if cmd == "raf3salem" then
if redis:sismember(nk..'salem:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ من قبل قرد  في المجموعه \n") 
end

redis:hset(nk..'username:'..UserID, 'username', Resolv)
redis:sadd(nk..'salem:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم رفعته قرد مجموعه \n") 
end

if cmd == "tnzelsalem" then
if not redis:sismember(nk..'salem:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم بالتأكيد تنزيل القرد \n") 
end
redis:srem(nk..'salem:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم تنزيله من قائمه القرده\n") 
end

if cmd == "raf3salem1" then
if redis:sismember(nk..'salem1:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ من قبل قلبك في المجموعه \n") 
end

redis:hset(nk..'username:'..UserID, 'username', Resolv)
redis:sadd(nk..'salem1:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم رفعته قلبك \n") 
end

if cmd == "tnzelsalem1" then
if not redis:sismember(nk..'salem1:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم بالتأكيد تنزيل قلبك \n") 
end
redis:srem(nk..'salem1:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم تنزيله من قائمه القلوب\n") 
end

if cmd == "raf3salem2" then
if redis:sismember(nk..'salem2:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ من قبل العضو وتكه في المجموعه \n") 
end

redis:hset(nk..'username:'..UserID, 'username', Resolv)
redis:sadd(nk..'salem2:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم رفعته وتكه \n") 
end

if cmd == "tnzelsalem2" then
if not redis:sismember(nk..'salem2:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم بالتأكيد تنزيل الوتكه \n") 
end
redis:srem(nk..'salem2:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم تنزيله من قائمه الوتك\n") 
end

if cmd == "raf3salem3" then
if redis:sismember(nk..'salem3:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ من قبلا زوجتك في المجموعه \n") 
end

redis:hset(nk..'username:'..UserID, 'username', Resolv)
redis:sadd(nk..'salem3:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم رفعتها زوجتك \n") 
end

if cmd == "tnzelsalem3" then
if not redis:sismember(nk..'salem3:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم بالتأكيد تنزيل الجثه من زوجاتك \n") 
end
redis:srem(nk..'salem3:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم تنزيله من قائمه زوجاتك\n") 
end

if cmd == "raf3salem4" then
if redis:sismember(nk..'salem4:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ من قبل زوجك في المجموعه \n") 
end

redis:hset(nk..'username:'..UserID, 'username', Resolv)
redis:sadd(nk..'salem4:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم رفعته زوجك دلعيه \n") 
end

if cmd == "tnzelsalem4" then
if not redis:sismember(nk..'salem4:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم بالتأكيد تنزيل العضو من قائمه ازواجك \n") 
end
redis:srem(nk..'salem4:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⤌ تم تنزيله من قائمه ازواجك\n") 
end



if cmd == "setwhitelist" then
if redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مميز من قبل") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار مميز") 
end
if cmd == "remwhitelist" then
if not redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ⇜ مو مميز من قبل") 
end
redis:srem(boss..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من المميز") 
end
if cmd == "setmnsha" then
if redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ منشئ من قبل") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار منشئ") 
end
if cmd == "remmnsha" then
if not redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مو منشئ من قبل ") 
end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من المنشئ") 
end

if cmd == "setowner" then
if redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مدير من قبل") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار مدير") 
end
if cmd == "remowner" then
if not redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ⇜ مو مدير من قبل") 
end
redis:srem(boss..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ تم نزلته من المدير") 
end
if cmd == "promote" then
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ادمن من قبل") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'admins:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار ادمن") 
end
if cmd == "demote" then
if not redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ⇜ مو ادمن من قبل") 
end
redis:srem(boss..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من الادمن") 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " مافيه " end
return SendMention(ChatID,UserID,MsgID,'⇜ الاسم ↭ '..namei..'\n'
..'⇜ الايدي ↭  ‹ '..UserID..' › \n'
..'⇜ المعرف ↭ '..useri..'\n'
..'⇜ الرتبه ↭ '..Getrtba(UserID,ChatID)..'\n'
..'⇜  نوع الكشف ↭ بالايدي\n',13,utf8.len(namei))
end)
end

if cmd == "Upmonsh" then
if redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مالك من قبل") 
end
redis:hset(boss..'username:'..UserID,'username',USERNAME)
redis:sadd(boss..':MONSHA_Group:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار مالك ") 
end

if cmd == "Dwmonsh" then
if not redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ⇜ مو مالك من قبل") 
end
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من المالك") 
end


if cmd == "UpMalk" then
if redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مالك اساسي من قبل") 
end
redis:hset(boss..'username:'..UserID,'username',USERNAME)
redis:sadd(boss..':Malk_Group:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر رفعته صار مالك اساسي") 
end

if cmd == "DwnMalk" then
if not redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ⇜ مو مالك اساسي من قبل") 
end
redis:srem(boss..':Malk_Group:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من المالك اساسي") 
end

if cmd == "up_sudo" then
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- من قبل مطور  في البوت ") 
end
redis:hset(boss..'username:'..UserID, 'username', USERNAME)
redis:sadd(boss..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- ابشر رفعته صار مطور  في البوت ") 
end

if cmd == "dn_sudo" then
if not redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مو مطور من قبل") 
end
redis:srem(boss..':SUDO_BOT:',UserID) 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ ابشر نزلته من مطور") 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر البوت  ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المنشئ الاساسي  ") 
elseif redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المدير ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر الادمن ")
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تحظر المميز ") 
end
if Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ محظور من قبل ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ تم حظرته ") 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"⇜ مايمديك تطرد البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تطرد مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تطرد المطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تطرد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تطرد اللمنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ هييه مايمديك تطرد المنشئ الاساسي ") 
elseif redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تطرد المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تطرد المدير ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تطرد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تطرد المميز ") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'- لا يمكنني طرد العضو .\n- لانه مشرف في المجموعه ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'- لا يمكنني طرد العضو .\n- ليس لدي صلاحيه الحظر او لست مشرف ❕')    
end
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ تم طردته") 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مو محظور") 
else
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n-  ⇜ تم الغيت عنه الحظر ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:srem(boss..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المنشئ الاساسي ") 
elseif redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المالك اساسي ")
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المدير ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تكتم المميز ") 
end
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤⇜ مايمديك تكتم المدراء او الادمنيه") 
end
if MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ كتمته من قبل") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ تم كتمته ") 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مو مكتوم") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:srem(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n-  ⇜ تم الغيت عنه الكتم ") 
end

if cmd == "upMshrf" then
redis:hset(boss..'username:'..UserID,'username',Resolv)
redis:setex(boss..":uploadingsomeon:"..ChatID..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..ChatID..msg.sender_user_id_,500,UserID)
sendMsg(ChatID,MsgID,"-  ↭ حسننا الان ارسل صلاحيات المشرف :\n\n|1- صلاحيه تغيير المعلومات\n|2- صلاحيه حذف الرسائل\n|3- صلاحيه دعوه مستخدمين\n|4- صلاحيه حظر وتقيد المستخدمين \n|5- صلاحيه تثبيت الرسائل \n|6- صلاحيه رفع مشرفين اخرين\n\n|[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n|[**] - لرفع كل الصلاحيات مع رفع المشرفين \n\n- يمكنك اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n| 136 آرماندو\n📬") 
return false
end

if cmd == "DwonMshrf" then
ResAdmin = UploadAdmin(ChatID,UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(ChatID,MsgID,"-لا يمكنني تنزيله لانه مرفوع من قبل منشئ اخر ")  end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n- تم تنزيله من مشرفين المجموعه ")
return false
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر البوت  ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر المطور الاساسي ")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ مايمديك تحظر المطور ") 
end
if GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ محظور عام من قبل في المجموعات ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'gban_users',UserID)
kick_user(UserID,ChatID) 
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n-  تم حظره عام  من المجموعات ") 
end

if cmd == "unbandall" then  
if not GeneralBanned(UserID) then
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ مو محظور عام من قبل في المجموعات ") 
end
redis:srem(boss..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n⇜ تم الغيت حظره العام  من المجموعات ") 
end

if cmd == "tfa3l" then  
local maseegs = redis:get(boss..'msgs:'..UserID..':'..ChatID) or 1
local edited = redis:get(boss..':edited:'..ChatID..':'..UserID) or 0
local content = redis:get(boss..':adduser:'..ChatID..':'..UserID) or 0
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "مافيه" end  

sendMsg(ChatID,MsgID,"⇜ايديه ↭ `"..UserID.."`\n⇜رسائله ↭ "..maseegs.."\n⇜معرفه ↭ ["..UserNameID.."]\n⇜تفاعله ↭ "..Get_Ttl(maseegs).."\n⇜رتبته ↭ "..Getrtba(UserID,ChatID).."\n⇜تعديلاته ↭ "..edited.."\n⇜جهاته ↭ "..content.."") 
end

if cmd == "rfaqud" then  
if UserID == our_id then return sendMsg(ChatID,MsgID,"⇜ لا يمكنك تنفيذ الامر بالرد ع رسالة البوت ") end
Restrict(ChatID,UserID,2)
redis:srem(boss..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
redis:srem(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」 \n  تم رفع القيود ان وجد ") 
end

--========================================================================
if cmd == "DwnAll" then ----------- تنزيل الكل
if UserID == our_id then return sendMsg(ChatID,MsgID,"⇜ مايمديك تنفيذ الامر مع البوت ❕") end
if UserID == 1910934437 or UserID == 1419573259 then return sendMsg(ChatID,MsgID,"⇜ مايمديك تنزل مطور السورس!") end

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':Malk_Group:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
rinkuser = 7
elseif redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
rinkuser = 8
else
rinkuser = 9
end
local DonisDown = "\n- تم تنزيله من الرتب الاتيه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."-   المطور  \n"
end 
if redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
DonisDown = DonisDown.."-   المنشئ الاساسي  \n"
end 
if redis:sismember(boss..':Malk_Group:'..ChatID,UserID) then 
DonisDown = DonisDown.."-  المالك اساسي  \n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
DonisDown = DonisDown.."-   المنشئ  \n"
end 
if redis:sismember(boss..'owners:'..ChatID,UserID) then 
DonisDown = DonisDown.."-   المدير  \n"
end 
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
DonisDown = DonisDown.."-   الادمن  \n"
end 
if redis:sismember(boss..'whitelist:'..ChatID,UserID) then
DonisDown = DonisDown.."-   العضو مميز  \n"
end

function senddwon()  sendMsg(ChatID,MsgID,"- معليش المستخدم رتبته اعلى منك لا يمكن تنزيله ❕") end
function sendpluse() sendMsg(ChatID,MsgID,"- معليش لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." ❕") end

if rinkuser == 9 then return sendMsg(ChatID,MsgID,"⇜ العضو「 "..NameUser.." 」   \nانه بالتاكيد عضو  ")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID)
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID)
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Malk then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID)
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.SuperCreator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 4 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Creator then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Director then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Admin then 
if rinkuser == 7 then return sendpluse() end
if rinkuser < 7 then return senddwon() end
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
else
huk = true
end

if not huk then sendMsg(ChatID,UserID,"⇜ العضو「 "..NameUser.." 」 \n"..DonisDown.."\n ") end

end

end

function settingsall(msg)

list_settings = "-` اعدادات المجموعه :` \n"
.."\n⇜ التعديل ⇜ "..(redis:get(boss..'lock_edit'..msg.chat_id_) or 'false')
.."\n⇜ الروابط ⇜ "..(redis:get(boss..'lock_link'..msg.chat_id_) or 'false')
.."\n⇜ التاك ⇜ "..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')
.."\n⇜ المعرفات ⇜ "..(redis:get(boss..'lock_username'..msg.chat_id_) or 'false')
.."\n\n⇜ التكرار ⇜ "..(redis:get(boss..'lock_flood'..msg.chat_id_) or 'false')
.."\n⇜ الكلايش ⇜ "..(redis:get(boss..'lock_spam'..msg.chat_id_) or 'false')
.."\n⇜ الويب ⇜ "..(redis:get(boss..'lock_webpage'..msg.chat_id_) or 'false')
.."\n⇜ الماركدوان ⇜ "..(redis:get(boss..'lock_markdown'..msg.chat_id_) or 'false')
.."\n⇜ البوتات بالطرد ⇜ "..(redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n⇜ البوتات ⇜ "..(redis:get(boss..'lock_bots'..msg.chat_id_) or 'false')
.."\n- عدد التكرار ⇜ "..(redis:get(boss..'num_msg_max'..msg.chat_id_) or 'false')
.."\n- وقت التنظيف ⇜ "..(redis:get(boss..':Timer_Cleaner:'..msg.chat_id_) or '6').." ساعة ."
.."\n\n-` اعدادات الوسائط :`\n"
.."\n⇜ المتحركه ⇜ "..(redis:get(boss..'mute_gif'..msg.chat_id_) or 'false')
.."\n⇜ الدردشه ⇜ "..(redis:get(boss..'mute_text'..msg.chat_id_) or 'false')
.."\n⇜ الانلاين ⇜ "..(redis:get(boss..'mute_inline'..msg.chat_id_) or 'false')
.."\n⇜ الالعاب ⇜ "..(redis:get(boss..'mute_game'..msg.chat_id_) or 'false')
.."\n⇜ الصور ⇜ "..(redis:get(boss..'mute_photo'..msg.chat_id_) or 'false')
.."\n⇜ الفيديو ⇜ "..(redis:get(boss..'mute_video'..msg.chat_id_) or 'false')
.."\n⇜ الصوت ⇜ "..(redis:get(boss..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n⇜ البصمات ⇜ "..(redis:get(boss..'mute_voice'..msg.chat_id_) or 'false')
.."\n⇜ الملصقات ⇜ "..(redis:get(boss..'mute_sticker'..msg.chat_id_) or 'false')
.."\n⇜ الجهات ⇜ "..(redis:get(boss..'mute_contact'..msg.chat_id_) or 'false')
.."\n⇜ التوجيه ⇜ "..(redis:get(boss..'mute_forward'..msg.chat_id_) or 'false')
.."\n⇜ الموقع ⇜ "..(redis:get(boss..'mute_location'..msg.chat_id_) or 'false')
.."\n⇜ الملفات ⇜ "..(redis:get(boss..'mute_document'..msg.chat_id_) or 'false')
.."\n⇜ الاشعارات ⇜ "..(redis:get(boss..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n⇜ السب ⇜ "..(redis:get(boss..'lock_mmno3'..msg.chat_id_) or 'false')
.."\n⇜ الفارسيه ⇜ "..(redis:get(boss..'lock_pharsi'..msg.chat_id_) or 'false')
.."\n⇜ الانقليزيه ⇜ "..(redis:get(boss..'lock_lang'..msg.chat_id_) or 'false')
.."\n⇜ الاضافه ⇜ "..(redis:get(boss..'lock_Add'..msg.chat_id_) or 'false')

local eueuf = "\n\n-` اعدادات اخرى : `"
.."\n⇜ الترحيب ⇜ "..(redis:get(boss..'welcome:get'..msg.chat_id_) or 'false')
.."\n- الردود ⇜ "..(redis:get(boss..'replay'..msg.chat_id_) or 'false')
.."\n- الردود العشوائيه ⇜ "..(redis:get(boss.."lock_RandomRdod"..msg.chat_id_) or 'false')
.."\n- التحذير ⇜ "..(redis:get(boss..'lock_woring'..msg.chat_id_) or 'false')
.."\n⇜ الايدي ⇜ "..(redis:get(boss..'lock_id'..msg.chat_id_) or 'false')
.."\n⇜ الرابط ⇜ "..(redis:get(boss..'lock_linkk'..msg.chat_id_) or 'false')
.."\n⇜ المغادره ⇜ "..(redis:get(boss..'lock_leftgroup'..msg.chat_id_) or 'false')
.."\n⇜ الحظر ⇜ "..(redis:get(boss..'lock_KickBan'..msg.chat_id_) or 'false')
.."\n⇜ الحمايه ⇜ "..(redis:get(boss..'antiedit'..msg.chat_id_) or 'false')
.."\n⇜  منشن ⇜ "..(redis:get(boss..'lock_takkl'..msg.chat_id_) or 'false')
.."\n⇜ الايدي بالصوره ⇜ "..(redis:get(boss..'idphoto'..msg.chat_id_) or 'false')
.."\n⇜ التحقق ⇜ "..(redis:get(boss.."lock_check"..msg.chat_id_) or 'false')
.."\n⇜ التنظيف التلقائي ⇜ "..(redis:get(boss.."lock_cleaner"..msg.chat_id_) or 'false')
.."\n- ردود السورس ⇜ "..(redis:get(boss.."lock_rdodSource"..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', ' (  مقفول  ) ')
list_settings = list_settings:gsub('false', ' (  مفتوح  ) ')
eueuf = eueuf:gsub('true', ' (  مفعل  ) ')
eueuf = eueuf:gsub('false', ' (  معطل  ) ')
return sendMsg(msg.chat_id_,1,'➖\n'..list_settings..eueuf..'\n')
end

function settings(msg)
list_settings = "`اعدادات المجموعه :` "
.."\n\n⇜ التاك ⇜ "..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')
.."\n⇜ المعرفات ⇜ "..(redis:get(boss..'lock_username'..msg.chat_id_) or 'false')
.."\n⇜ التعديل ⇜ "..(redis:get(boss..'lock_edit'..msg.chat_id_) or 'false')
.."\n⇜ الروابط ⇜ "..(redis:get(boss..'lock_link'..msg.chat_id_) or 'false')
.."\n\n⇜ التكرار ⇜ "..(redis:get(boss..'lock_flood'..msg.chat_id_) or 'false')
.."\n⇜ الكلايش ⇜ "..(redis:get(boss..'lock_spam'..msg.chat_id_) or 'false')
.."\n\n⇜ الويب ⇜ "..(redis:get(boss..'lock_webpage'..msg.chat_id_) or 'false')
.."\n⇜ الماركدوان ⇜ "..(redis:get(boss..'lock_markdown'..msg.chat_id_) or 'false')
.."\n⇜ البوتات بالطرد ⇜ "..(redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n⇜ البوتات ⇜ "..(redis:get(boss..'lock_bots'..msg.chat_id_) or 'false')
.."\n- عدد التكرار ⇜ "..(redis:get(boss..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\n-` اعدادات التقـييد :`\n"
.."\n⇜ التقييد بالتوجيه ⇜ "..(redis:get(boss..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n⇜ التقييد بالصور ⇜ "..(redis:get(boss..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n⇜ التقييد بالروابط ⇜ "..(redis:get(boss..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n⇜ التقييد بالمتحركه ⇜ "..(redis:get(boss..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n⇜ التقييد الفيديو ⇜ "..(redis:get(boss..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', ' (  مقفول  ) ')
list_settings = list_settings:gsub('false', ' (  مفتوح  ) ')
return sendMsg(msg.chat_id_, msg.id_,'➖\n'..list_settings..'\n')
end

function media(msg)
list_settings = "-` اعدادات الوسائط:`\n"
.."\n⇜ المتحركه ⇜ "..(redis:get(boss..'mute_gif'..msg.chat_id_) or 'false')
.."\n⇜ الدردشه ⇜ "..(redis:get(boss..'mute_text'..msg.chat_id_) or 'false')
.."\n⇜ الانلاين ⇜ "..(redis:get(boss..'mute_inline'..msg.chat_id_) or 'false')
.."\n⇜ الالعاب ⇜ "..(redis:get(boss..'mute_game'..msg.chat_id_) or 'false')
.."\n⇜ الصور ⇜ "..(redis:get(boss..'mute_photo'..msg.chat_id_) or 'false')
.."\n⇜ الفيديو ⇜ "..(redis:get(boss..'mute_video'..msg.chat_id_) or 'false')
.."\n⇜ الصوت ⇜ "..(redis:get(boss..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n⇜ البصمات ⇜ "..(redis:get(boss..'mute_voice'..msg.chat_id_) or 'false')
.."\n⇜ الملصقات ⇜ "..(redis:get(boss..'mute_sticker'..msg.chat_id_) or 'false')
.."\n⇜ الجهات ⇜ "..(redis:get(boss..'mute_contact'..msg.chat_id_) or 'false')
.."\n⇜ التوجيه ⇜ "..(redis:get(boss..'mute_forward'..msg.chat_id_) or 'false')
.."\n⇜ الموقع ⇜ "..(redis:get(boss..'mute_location'..msg.chat_id_) or 'false')
.."\n⇜ الملفات ⇜ "..(redis:get(boss..'mute_document'..msg.chat_id_) or 'false')
.."\n⇜ الاشعارات ⇜ "..(redis:get(boss..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n⇜ الكيبورد ⇜ "..(redis:get(boss..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', ' (  مقفول  ) ')
list_settings = list_settings:gsub('false', ' (  مفتوح  ) ')
return sendMsg(msg.chat_id_,msg.id_,'➖\n'..list_settings..'\n')
end
