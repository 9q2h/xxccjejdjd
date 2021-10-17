--[[
#---------------------------------------------------------------------
]]
local function iBoss(msg,MsgText)

if msg.forward_info_ then return false end


if msg.Director 
and (redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)) and MsgText[1] ~= "الغاء" then 
return false end 

if msg.type ~= 'pv' then if MsgText[1] == "تفعيل" and not MsgText[2] then
return modadd(msg)  
end

    
    
if MsgText[1] == "تعطيل" and not MsgText[2] then
if not msg.SudoUser then return '⇠ هذا الامر يخص المطور بس .'end
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if not redis:get(boss..'group:add'..msg.chat_id_) then return sendMsg(msg.chat_id_,msg.id_,'⇠ القروب معطل من قبل') end  
rem_data_group(msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'⇠ تـم تعطيل القروب \n⇠ من ⇠ 「 '..NameUser..' 」 \n')
end,{msg=msg})
end

end 


if msg.type ~= 'pv' and msg.GroupActive then 

if MsgText[1] == "ايدي" or MsgText[1]:lower() == "id" then
if not MsgText[2] and not msg.reply_id then
if redis:get(boss..'lock_id'..msg.chat_id_) then

GetUserID(msg.sender_user_id_,function(arg,data)

local msgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "🎫꒐ مـعرفك  ‹  @"..data.username_.."  › \n" else UserNameID = "" end
if data.username_ then UserNameID1 = "@"..data.username_ else UserNameID1 = "مافيه" end
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
local Namei = FlterName(data,20)
if data.status_.ID == "UserStatusEmpty" then
sendMsg(arg.chat_id_,data.id_,'⇠ مايمديني اعرض صورتك وانت حاظرني! \n\n')
else
local infouser = https.request("https://api.telegram.org/bot"..Token.."/getChat?chat_id="..msg.sender_user_id_)
local info_ = JSON.decode(infouser)
if info_.result.bio then
biouser = info_.result.bio
else
biouser = 'مافيه '
end

GetPhotoUser(data.id_,function(arg,data)
local edited = (redis:get(boss..':edited:'..arg.chat_id_..':'..arg.sender_user_id_) or 0)

local KleshaID = '↭↭ '..RandomText()..'\n\n👤꒐ اســمـك  ‹ '..arg.Namei..'  › \n'
..'⇠ ايديــك  ‹ '..arg.sender_user_id_..' › \n'
..arg.UserNameID
..'- رتبتـــك  ‹  '..arg.TheRank..'  › \n'
..'تفاعلك  ‹  '..Get_Ttl(arg.msgs)..' › \n'
..'- رسائلك  ‹ '..arg.msgs..' › \n'
..' البايو  '..biouser..' •\n'
local Kleshaidinfo = redis:get(boss..":infoiduser_public:"..arg.chat_id_) or redis:get(boss..":infoiduser")  

if Kleshaidinfo then 
local points = redis:get(boss..':User_Points:'..arg.chat_id_..arg.sender_user_id_) or 0
KleshaID = Kleshaidinfo:gsub("{الاسم}",arg.Namei)
KleshaID = KleshaID:gsub("{الايدي}",arg.sender_user_id_)
KleshaID = KleshaID:gsub("{اليوزر}",arg.UserNameID1)
KleshaID = KleshaID:gsub("{الرتبه}",arg.TheRank)
KleshaID = KleshaID:gsub("{التفاعل}",Get_Ttl(arg.msgs))
KleshaID = KleshaID:gsub("{الرسائل}",arg.msgs)
KleshaID = KleshaID:gsub("{التكليجات}",edited)
KleshaID = KleshaID:gsub("{المجوهرات}",points)
KleshaID = KleshaID:gsub("{البايو}",biouser)
KleshaID = KleshaID:gsub("{البوت}",redis:get(boss..':NameBot:'))
KleshaID = KleshaID:gsub("{المطور}",SUDO_USER)
KleshaID = KleshaID:gsub("{تعليق}",RandomText())
end
if redis:get(boss.."idphoto"..msg.chat_id_) then
if data.photos_ and data.photos_[0] then 
sendPhoto(arg.chat_id_,arg.id_,data.photos_[0].sizes_[1].photo_.persistent_id_,KleshaID,dl_cb,nil)
else
sendMsg(arg.chat_id_,arg.id_,'⇠ مافيه صوره في بروفايلك  › \n\n'..Flter_Markdown(KleshaID))
end
else
sendMsg(arg.chat_id_,arg.id_,Flter_Markdown(KleshaID))
end

end,{chat_id_=arg.chat_id_,id_=arg.id_,TheRank=arg.TheRank,sender_user_id_=data.id_,msgs=msgs,Namei=Namei,UserNameID=UserNameID,UserNameID1=UserNameID1})


end

end,{chat_id_=msg.chat_id_,id_=msg.id_,TheRank=msg.TheRank})

end
end




if msg.reply_id and not MsgText[2] then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"-معليشً هذا الحلو ليس موجود ضمن المجموعات\n") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERNAME = USERNAME:gsub([[\_]],"_")
USERCAR = utf8.len(USERNAME) 
SendMention(arg.ChatID,arg.UserID,arg.MsgID,""..arg.UserID.." ",37,USERCAR)
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر! \n") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
sendMsg(arg.ChatID,arg.MsgID,"⇠ اضـغط على الايدي ليتم النسـخ\n\n "..UserName.." ~⪼ ( `"..UserID.."` )")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
return false
end


if MsgText[1] == "تعديلاتي" or MsgText[1] == "تكليجاتي" then    
local numvv = redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0
return "⇠ عدد تكليجاتك هو : "..numvv
end




if MsgText[1] == "تغير الرتبه"  or MsgText[1] == "تغير رتبه" then    
if not msg.SuperCreator  then return "⇠ هذا الامر يخص ( المالك,المطور ) بس  \n" end
redis:setex(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_,1000,true)
redis:del(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
return [[
⇠ ارسل الرتبه المراد تغيرها

⇠ مالك اساسي 
⇠ مالك 
⇠ منشئ 
⇠ مدير 
⇠ ادمن 
⇠ مميز 

]]
end


if MsgText[1] == "مسح الرتبه" or MsgText[1] ==  "مسح رتبه" then    
if not msg.SuperCreator  then return "⇠ هذا الامر يخص ( المالك,المطور ) بس  \n" end
redis:setex(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_,1000,true)
return [[
⇠ تمام، ارسل الرتبه اللي تبي تحذفها 

⇠ مالك اساسي  
⇠ مالك 
⇠ منشئ
⇠ مدير 
⇠ ادمن 
⇠ مميز
]]
end
if MsgText[1] == "مسح قائمه الرتب" or MsgText[1] == "مسح الرتب" then    
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
redis:del(boss..":RtbaNew1:"..msg.chat_id_)
redis:del(boss..":RtbaNew2:"..msg.chat_id_)
redis:del(boss..":RtbaNew3:"..msg.chat_id_)
redis:del(boss..":RtbaNew4:"..msg.chat_id_)
redis:del(boss..":RtbaNew5:"..msg.chat_id_)
redis:del(boss..":RtbaNew6:"..msg.chat_id_)
redis:del(boss..":RtbaNew7:"..msg.chat_id_)
redis:del(boss..":RtbaNew8:"..msg.chat_id_)
return "⇠ تم حذفت القائمه بالكامل "
end



if MsgText[1] == "قائمه الرتب" then
if not msg.SuperCreator  then return "⇠ هذا الامر يخص ( المالك,المطور ) بس  \n" end

local Rtba1 = redis:get(boss..":RtbaNew1:"..msg.chat_id_) or " مافيه "
local Rtba2 = redis:get(boss..":RtbaNew2:"..msg.chat_id_) or " مافيه "
local Rtba3 = redis:get(boss..":RtbaNew3:"..msg.chat_id_) or " مافيه "
local Rtba4 = redis:get(boss..":RtbaNew4:"..msg.chat_id_) or " مافيه "
local Rtba5 = redis:get(boss..":RtbaNew5:"..msg.chat_id_) or " مافيه "
local Rtba6 = redis:get(boss..":RtbaNew6:"..msg.chat_id_) or " مافيه "
local Rtba7 = redis:get(boss..":RtbaNew7:"..msg.chat_id_) or " مافيه "
local Rtba8 = redis:get(boss..":RtbaNew8:"..msg.chat_id_) or " مافيه "

return "⇠ قائمه الرتب الجديده :\n\n⇠ Armndo ↭ ["..Rtba1.."]\n⇠ مالك اساسي  ↭ ["..Rtba8.."]\n⇠ مالك  ↭ ["..Rtba3.."]\n⇠ مطور  ↭ ["..Rtba2.."]\n⇠ منشئ  ↭ ["..Rtba4.."]\n⇠ مدير  ↭ ["..Rtba5.."]\n⇠ ادمن  ↭ ["..Rtba6.."]\n⇠ مميز  ↭ ["..Rtba7.."]\n"
end



if MsgText[1] == "المالك الاساسي"  or MsgText[1] == "المنشئ" or  MsgText[1] == "المالك" then
local url , res = https.request(ApiToken..'/getChatAdministrators?chat_id='..msg.chat_id_)
local get = JSON.decode(url)
for k,v in pairs(get.result) do
if v.status == "creator" and v.user.first_name ~= "" then
return sendMsg(msg.chat_id_,msg.id_," ["..v.user.first_name.."](t.me/"..(v.user.username or " EE6EE"))
end
end

message = ""
local monsha = redis:smembers(boss..':Malk_Group:'..msg.chat_id_)
if #monsha == 0 then 
sendMsg(msg.chat_id_,msg.id_,"⇠ مافيه مالك  !\n")
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
GetUserName(info.username,function(arg,data)

mmmmm = arg.UserName:gsub("@","")
sendMsg(arg.ChatID,arg.MsgID," ["..data.title_.."](t.me/"..mmmmm..")")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=info.username})
else
sendMsg(msg.chat_id_,msg.id_,' ['..info.username..'](t.me/ rnnni)  \n')
end

break

end
end
end

if MsgText[1] == "المجموعه" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
GetFullChat(msg.chat_id_,function(arg,data)
local GroupName = (redis:get(boss..'group:name'..arg.ChatID) or '')
redis:set(boss..'linkGroup'..arg.ChatID,(data.invite_link_ or ""))
sendMsg(arg.ChatID,arg.MsgID,
"- مـعـلومـات الـمـجـموعـه\n\n"
.."⇠ عدد الاعـضـاء ‹  *"..data.member_count_.."*  › "
.."\n⇠ عدد المحظـوريـن ‹  *"..data.kicked_count_.."*  › "
.."\n⇠ عدد الادمـنـيـه ‹  *"..data.administrator_count_.."*  › "
.."\n⇠ الايــدي  ‹  `"..arg.ChatID.."`  › "
.."\n\n⇠  ‹   ["..FlterName(GroupName).."]("..(data.invite_link_ or "")..")  ›  \n"
)
end,{ChatID=msg.chat_id_,MsgID=msg.id_}) 
return false
end



if MsgText[1] == "تثبيت" and msg.reply_id then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
local GroupID = msg.chat_id_:gsub('-100','')
if not msg.Director and redis:get(boss..'lock_pin'..msg.chat_id_) then
return "⇠ هييه مايمديك التثبيت الامر مقفول من قبل الاداره"
else
tdcli_function({
ID="PinChannelMessage",
channel_id_ = GroupID,
message_id_ = msg.reply_id,
disable_notification_ = 1},
function(arg,data)
if data.ID == "Ok" then
redis:set(boss..":MsgIDPin:"..arg.ChatID,arg.reply_id)
sendMsg(arg.ChatID,arg.MsgID,"⇠ اهلا عيني "..arg.TheRankCmd.." \n⇠ تم تثبيت الرساله ")
elseif data.ID == "Error" and data.code_ == 6 then
sendMsg(arg.ChatID,arg.MsgID,'⇠ معليش مقدر التثبيت\n لست مشرف او لا املك صلاحيه التثبيت ')    
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,reply_id=msg.reply_id,TheRankCmd=msg.TheRankCmd})
end
return false
end

if MsgText[1] == "مسح قائمه التثبيت" or MsgText[1] == "مسح قائمه تثبيت" or MsgText[1] == "مسح التثبيتات" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
if not msg.Director and redis:get(boss..'lock_pin'..msg.chat_id_) then return "⇠ هييه مايمديك الغاء التثبيت الامر مقفول من قبل الاداره" end
https.request(ApiToken..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
return "⇠ اهلا عيني "..msg.TheRankCmd.."  \n⇠ تم الغاء كل التثبيتات الرسائل"
end

if MsgText[1] == "مسح قائمه التثبيت" or MsgText[1] == "الغاء تثبيت" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
if not msg.Director and redis:get(boss..'lock_pin'..msg.chat_id_) then return "⇠ هييه مايمديك الغاء التثبيت الامر مقفول من قبل الاداره" end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
sendMsg(arg.ChatID,arg.MsgID,"⇠ اهلا عيني "..arg.TheRankCmd.."  \n⇠ تم الغاء تثبيت الرساله ")    
elseif data.ID == "Error" and data.code_ == 6 then
sendMsg(arg.ChatID,arg.MsgID,'⇠ معليش مقدر التثبيت\nلست مشرف او لا املك صلاحيه التثبيت ')    
elseif data.ID == "Error" and data.code_ == 400 then
sendMsg(arg.ChatID,arg.MsgID,'⇠ معليش عيني'..arg.TheRankCmd..' .\n⇠ لا توجد رساله مثبته لاقوم بازالتها ')    
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,TheRankCmd=msg.TheRankCmd})
return false
end

if MsgText[1] == "تقييد" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then  -- By Replay 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو مو موجود في المجموعه اصلا!") end
local UserID = data.sender_user_id_
if UserID == our_id then  
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259  then  
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد مطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المميز ") 
end
GetChatMember(arg.ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ تم قيدته") 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
Restrict(arg.ChatID,arg.UserID,1)
redis:set(boss..":TqeedUser:"..arg.ChatID..arg.UserID,true)
elseif data.status_.ID == "ChatMemberStatusLeft" then
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو مو موجود في المجموعه اصلا!") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر تقييد المشرف") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  -- By Username 
GetUserName(MsgText[2],function(arg,data)
print("1111")
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259  then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد مطور السورس ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد مطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تقيد المميز ") 
end
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
GetChatMember(arg.ChatID,arg.UserID,function(arg,data)
print(data.status_.ID)
if data.status_.ID == "ChatMemberStatusMember" then 
redis:set(boss..":TqeedUser:"..arg.ChatID..arg.UserID,true)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو ("..arg.NameUser.." ) \n ⇠ تم قيدته") 
Restrict(arg.ChatID,arg.UserID,1)  
elseif data.status_.ID == "ChatMemberStatusLeft" then
sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر تقيد الحلو لانه مغادر المجموعة ") 
else
sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر تقييد الحلو\n⇠ لانه مشرف \n𓍦')    
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=arg.UserName,UserID=arg.UserID,NameUser=arg.NameUser})
else
sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر تقييد الحلو\n🎟 لانني لست مشرف \n𓍦 \n ')    
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=arg.UserName,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]}) 
elseif MsgText[2] and MsgText[2]:match('^%d+$') then  -- By UserID
UserID =  MsgText[2] 
if UserID == our_id then   
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد البوت ") 
elseif UserID == "1419573259" or UserID == "1419573259" then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد مطور السورس ") 
elseif UserID == tostring(SUDO_ID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد مطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد المالك ") 
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد المدير ") 
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تقيد الادمن ") 
end
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="tqeed"})
end 
return false
end

if MsgText[1] == "فك التقييد" or MsgText[1] == "فك تقييد" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
Restrict(arg.ChatID,UserID,2)
redis:del(boss..":TqeedUser:"..arg.ChatID..UserID)
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_}) 


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  -- BY Username
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusEditor" then 
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر تقييد الحلو\n⇠ لانني لست مشرف \n𓍦')    
end
Restrict(arg.ChatID,arg.UserID,2)  
redis:del(boss..":TqeedUser:"..arg.ChatID..arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه حساب بهذا الايدي") end 
NameUser = Hyper_Link_Name(data)
if data.id_ == our_id then  
return sendMsg(ChatID,MsgID,"⇠ البوت ليس مقييد ") 
end
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusEditor" then 
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر قك تقييد الحلو\n⇠ لانني لست مشرف \n𓍦')    
end
redis:del(boss..":TqeedUser:"..arg.ChatID..arg.UserID)
Restrict(arg.ChatID,arg.UserID,2)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserID=data.id_,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end 
return false
end









if MsgText[1] == "رفع مميز" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..'whitelist:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مميز من قبل \n𓍦") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'whitelist:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مميز \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  --BY USERNAME
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر رفع حساب بوت") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش مقدر رفع البوت") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
UserName = arg.UserName
if redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مميز من قبل \n𓍦") 
end
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'whitelist:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مميز \n𓍦") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setwhitelist"})
end 
return false
end

if MsgText[1] == "تنزيل مميز" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'whitelist:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مميز من قبل \n𓍦") 
else
redis:srem(boss..'whitelist:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من االمميز \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مميز من قبل \n𓍦")
else
redis:srem(boss..'whitelist:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من االمميز \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remwhitelist"})
end 
return false
end

if (MsgText[1] == "رفع المدير"  or MsgText[1] == "رفع مدير" ) then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if redis:sismember(boss..'owners:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مدير من قبل \n𓍦")
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'owners:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مدير \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر رفع حساب بوت") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش مقدر رفع البوت") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
UserName = arg.UserName
if redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مدير من قبل \n𓍦")
else
redis:hset(boss..'username:'..UserID, 'username',UserName)
redis:sadd(boss..'owners:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مدير \n𓍦")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setowner"})
end 
return false
end

if (MsgText[1] == "تنزيل المدير" or MsgText[1] == "تنزيل مدير" ) then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'owners:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مدير من قبل \n𓍦") 
else
redis:srem(boss..'owners:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المدير \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مدير من قبل \n𓍦")  
else
redis:srem(boss..'owners:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المدير \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remowner"}) 
end 
return false
end
-------------===============================================================================
-------------===============================================================================

if (MsgText[1] == "رفع منشى" or MsgText[1] == "رفع منشئ") then
if not msg.SuperCreator then return "⇠ هذا الامر يخص ( المطور,Mishary ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ منشئ من قبل \n𓍦") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار منشئ \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر رفع حساب بوت") end 
NameUser = Hyper_Link_Name(data)
local UserID = data.id_
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش مقدر رفع البوت") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
UserName = arg.UserName
if redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ منشئ من قبل \n𓍦") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار منشئ \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setmnsha"})
end  
return false
end

if (MsgText[1] == "تنزيل منشى" or MsgText[1] == "تنزيل منشئ" ) then
if not msg.SuperCreator then return "⇠ هذا الامر يخص ( المطور,مطور الاساسي ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
local MsgID = arg.MsgID
local ChatID = arg.ChatID
if not data.sender_user_id_ then return sendMsg(ChatID,MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID) then
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو منشئ من قبل \n𓍦") 
else
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المنشئ \n𓍦") 
end
end,{ChatID=ChatID,UserID=UserID,MsgID=MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو منشئ من قبل \n𓍦") 
else
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المنشئ \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remmnsha"})
end 
return false
end

if MsgText[1] == "رفع ادمن" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser   = Hyper_Link_Name(data)
if redis:sismember(boss..'admins:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ ادمن من قبل \n𓍦") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'admins:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار ادمن \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر رفع حساب بوت") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش مقدر رفع البوت") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
UserName = arg.UserName
if redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ ادمن من قبل \n𓍦") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'admins:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار ادمن \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="promote"})
end 
return false
end

if MsgText[1] == "تنزيل ادمن" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'admins:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو ادمن من قبل \n𓍦") 
else
redis:srem(boss..'admins:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من الادمن \n𓍦") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
NameUser = Hyper_Link_Name(data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو ادمن من قبل \n𓍦") 
else
redis:srem(boss..'admins:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من الادمن \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="demote"})
end 
return false
end

if MsgText[1] == "التفاعل" then
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
local USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "مافيه" end  
local maseegs = redis:get(boss..'msgs:'..arg.UserID..':'..arg.ChatID) or 1
local edited = redis:get(boss..':edited:'..arg.ChatID..':'..arg.UserID) or 0
local content = redis:get(boss..':adduser:'..arg.ChatID..':'..arg.UserID) or 0
sendMsg(arg.ChatID,arg.MsgID,"⇠ الايدي ↭ `"..arg.UserID.."`\n⇠ رسائله ↭ "..maseegs.."\n⇠ يوزره ↭ ["..UserNameID.."]\n⇠ تفاعله ↭ "..Get_Ttl(maseegs).."\n⇠ رتبته ↭ "..Getrtba(arg.UserID,arg.ChatID).."\n تعديلاته ↭ "..edited.."\n⇠ جهاته  "..content.."") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
local USERNAME = arg.user
NameUser = Hyper_Link_Name(data)
local maseegs = redis:get(boss..'msgs:'..UserID..':'..arg.ChatID) or 1
local edited = redis:get(boss..':edited:'..arg.ChatID..':'..UserID) or 0
local content = redis:get(boss..':adduser:'..arg.ChatID..':'..UserID) or 0
sendMsg(arg.ChatID,arg.MsgID,"⇠ الايدي ↭ `"..UserID.."`\n⇠ رسائله ↭ "..maseegs.."\n⇠ يوزره ↭ ["..USERNAME.."]\n⇠ تفاعله ↭ "..Get_Ttl(maseegs).."\n⇠ رتبته ↭ ↭ "..Getrtba(UserID,arg.ChatID).."\n تعديلاته ↭ "..edited.."\n⇠ جهاته  "..content.."") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,user=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="tfa3l"}) 
end
return false
end

if MsgText[1] == "كشف" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERCAR = utf8.len(USERNAME)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " مافيه " end
SendMention(arg.ChatID,arg.UserID,arg.MsgID,'⇠ الاسم ↭ '..namei..'\n'
..'⇠ الايدي ↭  {'..arg.UserID..'} \n'
..'⇠ اليوزر ↭ '..useri..'\n'
..'⇠ الرتبه  ↭ '..Getrtba(arg.UserID,arg.ChatID)..'\n'
..'⇠ نوع الكشف  ↭ بالرد\n',13,utf8.len(namei))
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
sendMsg(arg.ChatID,arg.MsgID,'⇠ الاسم ↭ '..FlterName(data.title_,30)..'\n'..'⇠ الايدي ↭ {`'..UserID..'`} \n'..'⇠ اليوزر ↭ '..UserName..'\n⇠ الرتبه  ↭ '..Getrtba(UserID,arg.ChatID)..'\n⇠ نوع الكشف  ↭ باليوزر'..'')
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="whois"}) 
end
return false
end


if MsgText[1] == "رفع القيود" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
GetUserID(UserID,function(arg,data)
if msg.SudoBase then redis:srem(boss..'gban_users',arg.UserID)  end 
Restrict(arg.ChatID,arg.UserID,2)
redis:srem(boss..'banned:'..arg.ChatID,arg.UserID)
StatusLeft(arg.ChatID,arg.UserID)
redis:srem(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم رفع القيود ان وجد  \n") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر بالرد ع رسالة البوت") end
if msg.SudoBase then redis:srem(boss..'gban_users',UserID)  end 
Restrict(arg.ChatID,UserID,2)
redis:srem(boss..'banned:'..arg.ChatID,UserID)
StatusLeft(arg.ChatID,UserID)
redis:srem(boss..'is_silent_users:'..arg.ChatID,UserID)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم رفع القيود ان وجد  \n") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
if msg.SudoBase then redis:srem(boss..'gban_users',MsgText[2])  end 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="rfaqud"}) 
end 
return false
end

if MsgText[1] == "طرد" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not msg.Creator and not redis:get(boss.."lock_KickBan"..msg.chat_id_) then return "⇠ الامر معطل من قبل اداره المجموعة  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد مطور السورس") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد مطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"- ⇠ هييه مايمديك تطرد المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المميز ") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ لانه مشرف \n𓍦  ')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ ليس لدي صلاحيه الحظر او لست مشرف ')    
end
GetUserID(arg.UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ تم طردته") 
StatusLeft(arg.ChatID,arg.UserID)
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد البوت ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد مطور السورس") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد مطور الاساسي ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"- ⇠ هييه مايمديك تطرد المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تطرد المميز ") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر طرد الحلو .\n⇠ لانه مشرف \n𓍦  ')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر طرد الحلو .\n ⇠ ليس لدي صلاحيه الحظر او لست مشرف ')    
end
StatusLeft(arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو 「 "..arg.NameUser.." 」 \n ⇠ تم طردته") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=UserName,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="kick"}) 
end 
return false
end


if MsgText[1] == "حظر" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not msg.Creator and not redis:get(boss.."lock_KickBan"..msg.chat_id_) then return "⇠ الامر معطل من قبل اداره المجموعة  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور الاساسي ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور السورس ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المنشئ ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المالك اساسي ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المميز ")
end

kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ لانه مشرف \n𓍦  ')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ ليس لدي صلاحيه الحظر او لست مشرف ')    
else
GetUserID(arg.UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if redis:sismember(boss..'banned:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ محظور من قبل") 
end

redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'banned:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ ابشر حظرته") 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور الاساسي ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور السورس ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المنشئ ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المالك اساسي ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المالك ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر الادمن ") 
end
if data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
if redis:sismember(boss..'banned:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ محظور من قبل") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ لانه مشرف \n𓍦  ')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ مقدر حظر الحلو .\n⇠ ليس لدي صلاحيه الحظر او لست مشرف ')    
end
redis:hset(boss..'username:'..arg.UserID, 'username',arg.UserName)
redis:sadd(boss..'banned:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ تم حظرته") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=arg.UserName,UserID=UserID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ban"}) 
end 
return false
end

--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================


if MsgText[1] == "رفع مشرف" then
if not msg.SuperCreator then return "⇠ هذا الامر يخص {مالك,المطور ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_

GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:setex(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_,500,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ ↭ تمام الحين ارسل صلاحيات المشرف :\n\n1⇠ صلاحيه تغيير المعلومات\n2 ⇠ صلاحيه حذف الرسائل\n3⇠ صلاحيه دعوه مستخدمين\n4⇠ صلاحيه حظر وتقيدالحلوين \n5⇠ صلاحيه تثبيت الرسائل \n6⇠ صلاحيه رفع مشرفين اخرين\n\n[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n[**] ⇠ لرفع كل الصلاحيات مع رفع المشرفين \n\n⇠ تقدر اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n 136 مشمش\n～") 

end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
redis:hset(boss..'username:'..UserID,'username',arg.USERNAME)
redis:setex(boss..":uploadingsomeon:"..arg.ChatID..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..arg.ChatID..msg.sender_user_id_,500,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ ↭ تمام الحين ارسل صلاحيات المشرف :\n\n1⇠ صلاحيه تغيير المعلومات\n2 ⇠ صلاحيه حذف الرسائل\n꒐3⇠ صلاحيه دعوه مستخدمين\n4⇠ صلاحيه حظر وتقيدالحلوين \n5⇠ صلاحيه تثبيت الرسائل \n6⇠ صلاحيه رفع مشرفين اخرين\n\n[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n[**] ⇠ لرفع كل الصلاحيات مع رفع المشرفين \n\n⇠ تقدر اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n 136 مشمش\n～") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,USERNAME=MsgText[2]})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="upMshrf"}) 
end 
return false
end

if MsgText[1] == "تنزيل مشرف" then
if not msg.SuperCreator then return "⇠ هذا الامر يخص {مالك,المطور ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر تنفيذ الامر للبوت") end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
ResAdmin = UploadAdmin(arg.ChatID,arg.UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(arg.ChatID,arg.MsgID,"-مقدر تنزيله لانه مرفوع من قبل منشئ اخر ")  end
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
redis:srem(boss..'owners:'..arg.ChatID,arg.UserID)
redis:srem(boss..'admins:'..arg.ChatID,arg.UserID)
redis:srem(boss..'whitelist:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلتهه من مشرفين المجموعه") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
local UserID = data.id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر تنفيذ الامر للبوت") end
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local ResAdmin = UploadAdmin(arg.ChatID,UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(arg.ChatID,arg.MsgID,"-مقدر تنزيله لانه مرفوع من قبل منشئ اخر ")  end
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
redis:srem(boss..'owners:'..arg.ChatID,UserID)
redis:srem(boss..'admins:'..arg.ChatID,UserID)
redis:srem(boss..'whitelist:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلتهه من مشرفين المجموعه") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwonMshrf"}) 
end 
return false
end
--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================

if (MsgText[1] == "الغاء الحظر" or MsgText[1] == "الغاء حظر") and msg.Admin then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك استخدام الامر بالرد على البوت \n") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

GetChatMember(arg.ChatID,arg.UserID,function(arg,data)
if (data.status_.ID == "ChatMemberStatusKicked" or redis:sismember(boss..'banned:'..arg.ChatID,arg.UserID)) then
StatusLeft(arg.ChatID,arg.UserID,function(arg,data) 
if data.message_ and data.message_ == "CHAT_ADMIN_REQUIRED" then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش البوت ليس لديه صلاحيات الحظر \n")
else
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الحظر") 
end
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID,USERNAME=arg.USERNAME})
redis:srem(boss..'banned:'..arg.ChatID,arg.UserID)
else
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الحظر") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID,USERNAME=USERNAME})
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.id_ == our_id then return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تنفيذ الامر مع البوت \n") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'banned:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الحظر") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الحظر") 
end
redis:srem(boss..'banned:'..arg.ChatID,UserID)
StatusLeft(arg.ChatID,UserID)
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="uban"}) 
end 
return false
end


if MsgText[1] == "كتم" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم البوت  ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم مطور الاساسي ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم مطورالسورس ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مايمديك تكتم المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ ههييه مايمديك تكتم المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المميز  ") 
end
GetUserID(UserID,function(arg,data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..'is_silent_users:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ كتمته من قبل") 
else
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ تم كتمته") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم البوت  ") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم مطور الاساسي ") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم مطور السورس ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المطور ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المنشئ ") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المالك ") 
elseif redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المالك اساسي ") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المدير ") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم الادمن ") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تكتم المميز  ") 
end
if redis:sismember(boss..'is_silent_users:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ كتمته من قبل") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'is_silent_users:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n ⇠ تم كتمته") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ktm"}) 
end
return false
end


if MsgText[1] == "الغاء الكتم" or MsgText[1] == "الغاء كتم" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'is_silent_users:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الكتم") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الكتم") 
redis:srem(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'is_silent_users:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الكتم") 
else
redis:srem(boss..'is_silent_users:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغيت عنه الكتم") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unktm"}) 
end 
return false
end


--{ Commands For locks }

if MsgText[1] == "قفل الكل"		 then return lock_All(msg) end
if MsgText[1] == "قفل الوسائط" 	 then return lock_Media(msg) end
if MsgText[1] == "قفل الصور بالتقييد" 	 then return tqeed_photo(msg) end
if MsgText[1] == "قفل الفيديو بالتقييد"  then return tqeed_video(msg) end
if MsgText[1] == "قفل المتحركه بالتقييد" then return tqeed_gif(msg) end
if MsgText[1] == "قفل التوجيه بالتقييد"  then return tqeed_fwd(msg) end
if MsgText[1] == "قفل الروابط بالتقييد"  then return tqeed_link(msg) end
if MsgText[1] == "قفل الدردشه"    	     then return mute_text(msg) end
if MsgText[1] == "قفل المتحركه" 		 then return mute_gif(msg) end
if MsgText[1] == "قفل الصور" 			 then return mute_photo(msg) end
if MsgText[1] == "قفل الفيديو"			 then return mute_video(msg) end
if MsgText[1] == "قفل البصمات" 		then return mute_voice(msg) 	end
if MsgText[1] == "قفل الصوت" 		then return mute_audio(msg) 	end
if MsgText[1] == "قفل الملصقات" 	then return mute_sticker(msg) end
if MsgText[1] == "قفل الجهات" 		then return mute_contact(msg) end
if MsgText[1] == "قفل التوجيه" 		then return mute_forward(msg) end
if MsgText[1] == "قفل الموقع"	 	then return mute_location(msg) end
if MsgText[1] == "قفل الملفات" 		then return mute_document(msg) end
if MsgText[1] == "قفل الاشعارات" 	then return mute_tgservice(msg) end
if MsgText[1] == "قفل الانلاين" 		then return mute_inline(msg) end
if MsgText[1] == "قفل الالعاب" 		then return mute_game(msg) end
if MsgText[1] == "قفل الكيبورد" 	then return mute_keyboard(msg) end
if MsgText[1] == "قفل الروابط" 		then return lock_link(msg) end
if MsgText[1] == "قفل التاك" 		then return lock_tag(msg) end
if MsgText[1] == "قفل المعرفات" 	then return lock_username(msg) end
if MsgText[1] == "قفل التعديل" 		then return lock_edit(msg) end
if MsgText[1] == "قفل الكلايش" 		then return lock_spam(msg) end
if MsgText[1] == "قفل التكرار" 		then return lock_flood(msg) end
if MsgText[1] == "قفل البوتات" 		then return lock_bots(msg) end
if MsgText[1] == "قفل البوتات بالطرد" 	then return lock_bots_by_kick(msg) end
if MsgText[1] == "قفل الماركدوان" 	then return lock_markdown(msg) end
if MsgText[1] == "قفل الويب" 		then return lock_webpage(msg) end 
if MsgText[1] == "قفل التثبيت" 		then return lock_pin(msg) end 
if MsgText[1] == "قفل الاضافه" 		then return lock_Add(msg) end 
if MsgText[1] == "قفل الانقليزيه" 		then return lock_lang(msg) end 
if MsgText[1] == "قفل الفارسيه" 		then return lock_pharsi(msg) end 
if MsgText[1] == "قفل السب" 		then return lock_mmno3(msg) end 


--{ Commands For Unlocks }
if MsgText[1] == "فتح الكل" then return Unlock_All(msg) end
if MsgText[1] == "فتح الوسائط" then return Unlock_Media(msg) end
if MsgText[1] == "فتح الصور بالتقييد" 		then return fktqeed_photo(msg) 	end
if MsgText[1] == "فتح الفيديو بالتقييد" 	then return fktqeed_video(msg) 	end
if MsgText[1] == "فتح المتحركه بالتقييد" 	then return fktqeed_gif(msg) 	end
if MsgText[1] == "فتح التوجيه بالتقييد" 	then return fktqeed_fwd(msg) 	end
if MsgText[1] == "فتح الروابط بالتقييد" 	then return fktqeed_link(msg) 	end
if MsgText[1] == "فتح المتحركه" 	then return unmute_gif(msg) 	end
if MsgText[1] == "فتح الدردشه" 		then return unmute_text(msg) 	end
if MsgText[1] == "فتح الصور" 		then return unmute_photo(msg) 	end
if MsgText[1] == "فتح الفيديو" 		then return unmute_video(msg) 	end
if MsgText[1] == "فتح البصمات" 		then return unmute_voice(msg) 	end
if MsgText[1] == "فتح الصوت" 		then return unmute_audio(msg) 	end
if MsgText[1] == "فتح الملصقات" 	then return unmute_sticker(msg) end
if MsgText[1] == "فتح الجهات" 		then return unmute_contact(msg) end
if MsgText[1] == "فتح التوجيه" 		then return unmute_forward(msg) end
if MsgText[1] == "فتح الموقع" 		then return unmute_location(msg) end
if MsgText[1] == "فتح الملفات" 		then return unmute_document(msg) end
if MsgText[1] == "فتح الاشعارات" 	then return unmute_tgservice(msg) end
if MsgText[1] == "فتح الانلاين" 		then return unmute_inline(msg) 	end
if MsgText[1] == "فتح الالعاب" 		then return unmute_game(msg) 	end
if MsgText[1] == "فتح الكيبورد" 	then return unmute_keyboard(msg) end
if MsgText[1] == "فتح الروابط" 		then return unlock_link(msg) 	end
if MsgText[1] == "فتح التاك" 		then return unlock_tag(msg) 	end
if MsgText[1] == "فتح المعرفات" 	then return unlock_username(msg) end
if MsgText[1] == "فتح التعديل" 		then return unlock_edit(msg) 	end
if MsgText[1] == "فتح الكلايش" 		then return unlock_spam(msg) 	end
if MsgText[1] == "فتح التكرار" 		then return unlock_flood(msg) 	end
if MsgText[1] == "فتح البوتات" 		then return unlock_bots(msg) 	end
if MsgText[1] == "فتح البوتات بالطرد" 	then return unlock_bots_by_kick(msg) end
if MsgText[1] == "فتح الماركدوان" 	then return unlock_markdown(msg) end
if MsgText[1] == "فتح الويب" 		then return unlock_webpage(msg) 	end
if MsgText[1] == "فتح التثبيت" 		then return unlock_pin(msg) end 
if MsgText[1] == "فتح الاضافه" 		then return unlock_Add(msg) end 
if MsgText[1] == "فتح الانقليزيه" 		then return unlock_lang(msg) end 
if MsgText[1] == "فتح الفارسيه" 		then  return unlock_pharsi(msg) end 
if MsgText[1] == "فتح السب" 		then return unlock_mmno3(msg) end 


if MsgText[1] == "ضع رابط" then
if not msg.Creator  then return "⇠ هذا الامر يخص ( المطور,المالك ,المنشئ ) بس  \n" end 
redis:setex(boss..'WiCmdLink'..msg.chat_id_..msg.sender_user_id_,500,true)
return '⇠ تمام عيني\n⇠ الحين ارسل  رابط مجموعتك '
end

if MsgText[1] == "انشاء رابط" then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المالك ,المنشئ ) بس  \n" end
if not redis:get(boss..'ExCmdLink'..msg.chat_id_) then
local LinkGp = ExportLink(msg.chat_id_)
if LinkGp then
LinkGp = LinkGp.result
redis:set(boss..'linkGroup'..msg.chat_id_,LinkGp)
redis:setex(boss..'ExCmdLink'..msg.chat_id_,120,true)
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم انشاء رابط جديد \n⇠ ["..LinkGp.."]\n⇠ لعرض الرابط ارسل { الرابط } \n")
else
return sendMsg(msg.chat_id_,msg.id_,"⇠ مقدر انشاء رابط للمجموعه \n⇠ لانني لست مشرف \n𓍦 ")
end
else
return sendMsg(msg.chat_id_,msg.id_,"- لقد قمت بانشاء الرابط سابقا .\n⇠ يرجى الانتظار  { 4 دقيقة } \n  ⇠ لكي تستطيع انشاء رابط جديد")
end
return false
end 

if MsgText[1] == "الرابط" then
if not redis:get( boss.."lock_linkk"..msg.chat_id_) then return "⇠ الامر معطل من قبل الادارة \n^"  end
if not redis:get( boss..'linkGroup'..msg.chat_id_) then return "⇠ مافيه رابط\n⇠ لانشاء رابط ارسل { انشاء رابط } \n" end
local GroupName = redis:get( boss..'group:name'..msg.chat_id_)
local GroupLink = redis:get( boss..'linkGroup'..msg.chat_id_)
local LinkG = "["..GroupName.."]("..GroupLink..")"
return 
sendMsgg(msg.chat_id_,msg.id_,LinkG)
end

if MsgText[1] == 'البايو'   or MsgText[1] == "بايو" then
  if msg.reply_id then 
    function get(mr,EIKOei)
      if not EIKOei.sender_user_id_ then
        return false
      end
      local infouser = https.request("https://api.telegram.org/bot"..Token.."/getChat?chat_id="..EIKOei.sender_user_id_)
      local info_ = JSON.decode(infouser)
      if info_.result.bio then
        biouser = info_.result.bio
      else
        biouser = 'مافيه '
      end
      sendMsg(msg.chat_id_,msg.id_,biouser)
    end
    GetMsgInfo(msg.chat_id_,msg.reply_id,get,nil)
  else
    local infouser = https.request("https://api.telegram.org/bot"..Token.."/getChat?chat_id="..msg.sender_user_id_)
    local info_ = JSON.decode(infouser)
    if info_.result.bio then
      biouser = info_.result.bio
    else
      biouser = 'مافيه '
    end
    sendMsg(msg.chat_id_,msg.id_,biouser)
  end
end

if MsgText[1] == "ضع القوانين" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
redis:setex(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_,300,true)
return '⇠ تمام عيني\n⇠ الحين ارسل القوانين  للمجموعه '
end

if MsgText[1] == "القوانين" then
if not redis:get(boss..'rulse:msg'..msg.chat_id_) then 
return [[
⇠ مرحبا عزيري القوانين  
⇠ ممنوع نشر الروابط 
⇠ ممنوع التكلم او نشر صور اباحيه 
⇠ ممنوع اعاده توجيه
⇠ ممنوع التكلم بلطائفه 
⇠ الرجاء احترام المدراء والادمنيه
]]
else 
return "⇠ القوانين :\n"..redis:get(boss..'rulse:msg'..msg.chat_id_) 
end 
end

if MsgText[1] == "ضع تكرار" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
local NumLoop = tonumber(MsgText[2])
if NumLoop < 1 or NumLoop > 50 then 
return "⇠ حدود التكرار ,  لازم ان يكون التكرار ما بين  [2-50]" 
end
redis:set(boss..'num_msg_max'..msg.chat_id_,MsgText[2]) 
return "⇠ تم سويت التكرار ↭ { *"..MsgText[2].."* }"
end

if MsgText[1] == "ضع وقت التنظيف" then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local NumLoop = tonumber(MsgText[2])
redis:set(boss..':Timer_Cleaner:'..msg.chat_id_,NumLoop) 
return "⇠ تم سويت وقت التنظيف ↭  { *"..MsgText[2].."* } ساعه"
end


    
    

    
    
    
    if MsgText[1] == "مسح معلوماتي" then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:del(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:del(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:del(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:del(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:del(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:del(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:del(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:del(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:del(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info ="⇠ ابشر مسحت كل معلوماتك"
return sendMsg(msg.chat_id_,msg.id_,Get_info)    
end,nil)
return false
end
    
    if MsgText[1] == 'مسح' and MsgText[2] == 'رسائلي'  then
local msgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if rfih == 0 then  return "✘معليش مافيه رسائل لك في البوت  ." end
redis:del(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
return "تم مسحت (* "..msgs.." *) من رسائلك \n"
end
    
    
    

if MsgText[1] == "مسح المالكيين الاساسين" or MsgText[1] == "مسح المالكيين الاساسيين" or MsgText[1] == "مسح المالكين الاساسين" or MsgText[1] == "حذف المالكين الاساسين" then 
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end

local Admins = redis:scard(boss..':Malk_Group:'..msg.chat_id_)
if Admins == 0 then  
return "مافيه مالك اساسيين عشان امسحهم!\n " 
end
redis:del(boss..':Malk_Group:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت {"..Admins.."} من المالكين اساسيين في البوت "
end
--=======================================================
--=======================================================
--=======================================================
if MsgText[1] == "مسح المالكين" or MsgText[1] == "مسح المالكيين" or MsgText[1] == "مسح المنشئيين الاساسين" or MsgText[1] == "حذف المالكين" then 
if not msg.Malk then return "⇠ هذا الامر يخص ( المطور,المالك اساسي) بس  \n" end

local Admins = redis:scard(boss..':MONSHA_Group:'..msg.chat_id_)
if Admins == 0 then  
return "مافيه مالكين عشان امسحهم!\n " 
end
redis:del(boss..':MONSHA_Group:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت {"..Admins.."} من المالكين في البوت "
end

if MsgText[1] == "مسح الرسائل المجدوله" or MsgText[1] == "مسح الميديا" or MsgText[1] == "مسح الوسائط" then 
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
local mmezz = redis:smembers(boss..":IdsMsgsCleaner:"..msg.chat_id_)
if #mmezz == 0 then return "⇠  مافيه وسائط مجدوله للحذف او \n امر التنظيف تم تعطيله من قبل المالك " end
for k,v in pairs(mmezz) do
Del_msg(msg.chat_id_,v)
end
return "⇠ تم مسحت جميع الوسائط المجدوله" 
end

if MsgText[1] == "مسح التعديلات"  or MsgText[1] == "مسح تكليجاتي" or MsgText[1] == "مسح تعديلاتي" then    
redis:del(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
return "⇠ تم مسحت جميع تكليجاتك" 
end

if MsgText[1] == "مسح الادمنيه" then 
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end

local Admins = redis:scard(boss..'admins:'..msg.chat_id_)
if Admins == 0 then  
return "مافيه ادمنيه عشان امسحهم!\n " 
end
redis:del(boss..'admins:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت {"..Admins.."} من الادمنيه في البوت "
end


if MsgText[1] == "مسح قائمه المنع" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local Mn3Word = redis:scard(boss..':Filter_Word:'..msg.chat_id_)
if Mn3Word == 0 then 
return "⇠ معليش لا توجد كلمات ممنوعه ليتم حذفتها " 
end
redis:del(boss..':Filter_Word:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت {*"..Mn3Word.."*} كلمات من المنع "
end


if MsgText[1] == "مسح القوانين" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if not redis:get(boss..'rulse:msg'..msg.chat_id_) then 
return "⇠ معليش مافيه قوانين ليتم مسحته \n!" 
end
redis:del(boss..'rulse:msg'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم حذفت القوانين  \n"
end


if MsgText[1] == "مسح الترحيب"  then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if not redis:get(boss..'welcome:msg'..msg.chat_id_) then 
return "⇠ مافيه ترحيب عشان امسحه! " 
end
redis:del(boss..'welcome:msg'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠ تم حذفت الترحيب  \n"
end


if MsgText[1] == "مسح المالكين" or MsgText[1] == "مسح المالكيين" then
if not msg.SuperCreator    then return "⇠ هذا الامر يخص ( المطور,منشئ الاساسي) بس  \n" end
local NumMnsha = redis:scard(boss..':MONSHA_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
return "⇠ معليش مافيه مالكين ليتم مسحتهم \n!" 
end
redis:del(boss..':MONSHA_BOT:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠  تم مسحت {* "..NumMnsha.." *} من المالكين "
end


if MsgText[1] == "مسح المدراء" then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
local NumMDER = redis:scard(boss..'owners:'..msg.chat_id_)
if NumMDER ==0 then 
return "⇠ معليش مافيه مدراء ليتم مسحتهم \n!" 
end
redis:del(boss..'owners:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠  تم مسحت {* "..NumMDER.." *} من المدراء  "
end

if MsgText[1] == 'مسح المحظورين' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end

local list = redis:smembers(boss..'banned:'..msg.chat_id_)
if #list == 0 then return "⇠  مافيه مستخدمين محظورين " end
message = '📋*꒐* قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
StatusLeft(msg.chat_id_,v)
end 
redis:del(boss..'banned:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠  تم مسحت {* "..#list.." *} من المحظورين "
end

if MsgText[1] == 'مسح المكتومين' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local MKTOMEN = redis:scard(boss..'is_silent_users:'..msg.chat_id_)
if MKTOMEN ==0 then 
return "⇠  مافيه مستخدمين مكتومين في المجموعه " 
end
redis:del(boss..'is_silent_users:'..msg.chat_id_)
return "⇠ من ⇠  "..msg.TheRankCmd.."   \n⇠  تم مسحت {* "..MKTOMEN.." *} من المكتومين "
end

if MsgText[1] == 'مسح المميزين' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local MMEZEN = redis:scard(boss..'whitelist:'..msg.chat_id_)
if MMEZEN ==0 then 
return "⇠ مافيه مستخدمين مميزين في المجموعه " 
end
redis:del(boss..'whitelist:'..msg.chat_id_)
return "- من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت {* "..MMEZEN.." *} من المميزين  "
end

if MsgText[1] == 'مسح الرابط' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if not redis:get(boss..'linkGroup'..msg.chat_id_) then 
return "⇠ مافيه رابط مضاف اصلا " 
end
redis:del(boss..'linkGroup'..msg.chat_id_)
return "- من ⇠  "..msg.TheRankCmd.."   \n⇠ تم مسحت رابط المجموعه"
end


if MsgText[1] == "مسح" then
if not MsgText[2] and msg.reply_id then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
Del_msg(msg.chat_id_, msg.reply_id) 
Del_msg(msg.chat_id_, msg.id_) 
return false
end

if MsgText[2] and MsgText[2]:match('^%d+$') then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
if 100 < tonumber(MsgText[2]) then return "⇠ * حدود المسح ,  لازم تكون ما بين  *[2-100]" end
local DelMsg = MsgText[2] + 1
GetHistory(msg.chat_id_,DelMsg,function(arg,data)
All_Msgs = {}
for k, v in pairs(data.messages_) do
if k ~= 0 then
if k == 1 then
All_Msgs[0] = v.id_
else
table.insert(All_Msgs,v.id_)
end  
end 
end 
if tonumber(DelMsg) == data.total_count_ then
tdcli_function({ID="DeleteMessages",chat_id_ = msg.chat_id_,message_ids_=All_Msgs},function() 
sendMsg(msg.chat_id_,msg.id_,"⇠ تـم مسحت ~ ( *"..MsgText[2].."* ) من الرسائل  ")
end,nil)
else
tdcli_function({ID="DeleteMessages",chat_id_=msg.chat_id_,message_ids_=All_Msgs},function() 
sendMsg(msg.chat_id_,msg.id_,"⇠ تـم مسحت ~ ( *"..MsgText[2].."* ) من الرسائل  ")
end,nil)
end
end)
return false
end
end 

--End del 

if MsgText[1] == "ضع اسم" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
redis:setex(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام عيني\n⇠ الحين ارسل اسم  للمجموعه "
end

if MsgText[1] == "حذف صوره" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
tdcli_function({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = {ID = "InputFileId", id_ = 0}},function(arg,data)
if data.message_ and data.message_ == "CHAT_NOT_MODIFIED" then
sendMsg(arg.ChatID,arg.MsgID,'⇠ معليش ,  مافيه صوره اصلا في المجموعة')
elseif data.message_ and data.message_ == "CHAT_ADMIN_REQUIRED" then
sendMsg(arg.ChatID,arg.MsgID,'⇠   ماعندي صلاحيه عشان اعدل في المجموعة ')
else
sendMsg(arg.ChatID,arg.MsgID,'⇠ تم حذفت صوره المجموعه ')
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "ضع صوره" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then 
photo_id = data.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({
ID="ChangeChatPhoto",
chat_id_=arg.ChatID,
photo_ = GetInputFile(photo_id)},
function(arg,data)
if data.code_ and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'⇠ ليس لدي صلاحيه تغيير الصوره \n⇠ يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ')
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.reply_id})
return false
else 
redis:setex(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_,300,true)
return '⇠ تمام عيني \n⇠ الحين قم بارسال الصوره' 
end 
end

if MsgText[1] == "ضع وصف" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
redis:setex(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_,300,true) 
return "⇠ تمام عيني\n⇠ الحين ارسل الوصف  للمجموعه" 
end
if MsgText[1] == "@all" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس \n" end
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa)  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,datate) 
x = 0 
tags = 0 
local list = datate.members_  
for k, v in pairs(list) do 
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data) 
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
t = "#all" 
end 
x = x + 1 
tagname = data.first_name_ 
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")" 
if x == 5 or x == tags or k == 0 then 
local Text = t:gsub(',','\n') 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end 
end,nil) 
end 
end,nil) 
end,nil) 
end
    if MsgText[1] == "تاق للكل" or MsgText[1] == "منشن للكل" then    
if not msg.Admin then return "⇠ هذا الامر يخص (الادمن,المدير,المنشئ,المطور) بس  \n" end
return ownerlistv(msg) .. GetListAdmin(msg) .. whitelist(msg)
end
    
    
    
    
    
if MsgText[1] == "" or MsgText[1] == "" or MsgText[1] == "الاداريين" or MsgText[1] == "منشششن للكل" then   
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not redis:get(boss.."lock_takkl"..msg.chat_id_) then  return "⇠ الامر معطل من قبل الادراة" end 
if redis:get(boss.."chat:tagall"..msg.chat_id_) then  return "⇠ انتظر شوي ومنشن مره ثانيه" end 
redis:setex(boss..'chat:tagall'..msg.chat_id_,1,true)
return TagAll(msg) 
end

if MsgText[1] == "منشن" or MsgText[1] == "تاق"  then   
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if not redis:get(boss.."lock_takkl"..msg.chat_id_) then  return "⇠ الامر معطل عشان تفعله ارسل ( `تفعيل المنشن` )" end 
if redis:get(boss.."chat:tagall"..msg.chat_id_) then  return "⇠ انتظر شوي ومنشن مره ثانيه" end 
redis:setex(boss..'chat:tagall'..msg.chat_id_,1,true)
if MsgText[2] and MsgText[2]:match('^ل %d+$') then
taglimit = MsgText[2]:match('^ل %d+$'):gsub('ل ','')

else
taglimit = 200
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = taglimit
},function(ta,moody)
x = 0
list = moody.members_
for k, v in pairs(list) do
GetUserID(v.user_id_,function(arg,data)
x = x + 1
if x == 1 then
t = "⇠ قائمة الاعضاء \n\n"
end
if data.username_ then
t = t..""..x.." ([@"..data.username_.."]) \n"
else
tagname = FlterName(data.first_name_..' '..(data.last_name_ or ""),20)
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..""..x.."-  (["..tagname.."](tg://user?id="..v.user_id_..")) \n"
end
if k == 0 then
send_msg(msg.chat_id_,t,msg.id_)
end
end)
end
end,nil)
end





if MsgText[1] == "منع" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if MsgText[2] then
return AddFilter(msg, MsgText[2]) 
elseif msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == "MessageText" then
Type_id = data.content_.text_
elseif data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then Type_id = data.content_.photo_.sizes_[3].photo_.persistent_id_ else Type_id = data.content_.photo_.sizes_[0].photo_.persistent_id_ end
elseif data.content_.ID == "MessageSticker" then
Type_id = data.content_.sticker_.sticker_.persistent_id_
elseif data.content_.ID == "MessageVoice" then
Type_id = data.content_.voice_.voice_.persistent_id_
elseif data.content_.ID == "MessageAnimation" then
Type_id = data.content_.animation_.animation_.persistent_id_
elseif data.content_.ID == "MessageVideo" then
Type_id = data.content_.video_.video_.persistent_id_
elseif data.content_.ID == "MessageAudio" then
Type_id = data.content_.audio_.audio_.persistent_id_
elseif data.content_.ID == "MessageUnsupported" then
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش الرساله مو مدعومه ️")
else
Type_id = 0
end

if redis:sismember(boss..':Filter_Word:'..arg.ChatID,Type_id) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ موجود من قبل في قائمه المنع️")
else
redis:sadd(boss..':Filter_Word:'..arg.ChatID,Type_id) 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ تمت اضفتها الى قائمه المنع ️")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
return false 
end

if MsgText[1] == "الغاء منع" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
if MsgText[2] then
return RemFilter(msg,MsgText[2]) 
elseif msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if msg.content_.ID == "MessageText" then
Type_id = data.content_.text_
elseif data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then Type_id = data.content_.photo_.sizes_[3].photo_.persistent_id_ else Type_id = data.content_.photo_.sizes_[0].photo_.persistent_id_ end
elseif data.content_.ID == "MessageSticker" then
Type_id = data.content_.sticker_.sticker_.persistent_id_
elseif data.content_.ID == "MessageVoice" then
Type_id = data.content_.voice_.voice_.persistent_id_
elseif data.content_.ID == "MessageAnimation" then
Type_id = data.content_.animation_.animation_.persistent_id_
elseif data.content_.ID == "MessageVideo" then
Type_id = data.content_.video_.video_.persistent_id_
elseif data.content_.ID == "MessageAudio" then
Type_id = data.content_.audio_.audio_.persistent_id_
end
if redis:sismember(boss..':Filter_Word:'..arg.ChatID,Type_id) then 
redis:srem(boss..':Filter_Word:'..arg.ChatID,Type_id) 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ تم السماح بها ️")
else
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هذي مسموح بها من قبل ️")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
return false 
end

if MsgText[1] == "قائمه المنع" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return FilterXList(msg) 
end

if MsgText[1] == "الحمايه" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return settingsall(msg) 
end

if MsgText[1] == "الاعدادات" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return settings(msg) 
end

if MsgText[1] == "الوسائط" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return media(msg) 
end

if MsgText[1] == "الادمنيه" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return GetListAdmin(msg) 
end

if MsgText[1] == "المدراء" then 
if not msg.Director  then return "⇠ هذا الامر يخص ( المدير,المنشئ,المطور ) بس  \n" end
return ownerlist(msg) 
end

if MsgText[1] == "المالكين الاساسيين" then 
if not msg.Creator  then return "⇠ هذا الامر يخص ( المطور ,المالك ,المنشئ ) بس  \n" end
return Malklist(msg)
end
if MsgText[1] == "المالكين"  or MsgText[1] == "المالكيين" then 
if not msg.Creator  then return "⇠ هذا الامر يخص ( المطور ,المالك ,المنشئ ) بس  \n" end
return conslist(msg)
end

if MsgText[1] == "المميزين" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
return whitelist(msg) 
end



if MsgText[1] == "قائمه التيوس" then 
return salem(msg) 
end
if MsgText[1] == "قائمه القلوب" then 
return salem1(msg) 
end
if MsgText[1] == "قائمه الوتك" then 
return salem2(msg) 
end
if MsgText[1] == "قائمه زوجاتي" then 
return salem3(msg) 
end
if MsgText[1] == "قائمه ازواجي" then 
return salem4(msg) 
end

if MsgText[1] == "صلاحياته" then 
if not msg.Director  then return "⇠ هذا الامر يخص ( المدير,المنشئ,المطور ) بس  \n" end
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
if MsgText[1] == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
if MsgText[1] == "صلاحياته" and MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
if not msg.Director  then return "⇠ هذا الامر يخص ( المدير,المنشئ,المطور ) بس  \n" end
if tonumber(msg.reply_to_message_id_) == 0 then 
local username = MsgText[2]
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
return sendMsg(msg.chat_id_,msg.id_,'⇠اليوزر غير صحيح \n')   
end   
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return sendMsg(msg.chat_id_,msg.id_,'⇠هذا يوزر قناة \n')   
end      
Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end



if MsgText[1] == "طرد البوتات" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),filter_={ID="ChannelMembersBots"},offset_=0,limit_=50},
function(arg,data)
local Total = data.total_count_ or 0
if Total == 1 then
return sendMsg(arg.ChatID,arg.MsgID,"⇠ لا يـوجـد بـوتـات في الـمـجـمـوعـه .") 
else
local NumBot = 0
local NumBotAdmin = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then
kick_user(v.user_id_,arg.ChatID,function(arg,data)
if data.ID == "Ok" then
NumBot = NumBot + 1
else
NumBotAdmin = NumBotAdmin + 1
end
local TotalBots = NumBot + NumBotAdmin  
if TotalBots  == Total - 1 then
local TextR  = "⇠ عـدد الـبـوتات  (* "..(Total - 1).." *) \n\n"
if NumBot == 0 then 
TextR = TextR.."⇠ مقدر اطردهم عشانهم مشرفين\n"
else
if NumBotAdmin >= 1 then
TextR = TextR.."⇠ مايمدي اطرد (* "..NumBotAdmin.." *) بوتات عشانهم مشرفين"
else
TextR = TextR.."⇠ ابشر طردد كــل البوتات  .\n"
end
end
return sendMsg(arg.ChatID,arg.MsgID,TextR) 
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "كشف البوتات" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),
filter_ ={ID= "ChannelMembersBots"},offset_ = 0,limit_ = 50},function(arg,data)
local total = data.total_count_ or 0
AllBots = '⇠ قـائمه البوتات الـحالية\n\n'
local NumBot = 0
for k, v in pairs(data.members_) do
GetUserID(v.user_id_,function(arg,data)
if v.status_.ID == "ChatMemberStatusEditor" then
BotAdmin = "↭ *★*"
else
BotAdmin = ""
end
NumBot = NumBot + 1
AllBots = AllBots..NumBot..'- @['..data.username_..'] '..BotAdmin..'\n'
if NumBot == total then
AllBots = AllBots..[[

- عندك الحين (]]..total..[[) بـوتـات
- ملاحظة : الـ ★ يعني البوت مشرف في القروب]]
sendMsg(arg.ChatID,arg.MsgID,AllBots) 
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == 'طرد المحذوفين' then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المنشئ ) بس  \n" end
sendMsg(msg.chat_id_,msg.id_,'- جاري البحث عـن الـحـسـابـات المـحذوفـة ...')
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100','')
,offset_ = 0,limit_ = 200},function(arg,data)
if data.total_count_ and data.total_count_ <= 200 then
Total = data.total_count_ or 0
else
Total = 200
end
local NumMem = 0
local NumMemDone = 0
for k, v in pairs(data.members_) do 
GetUserID(v.user_id_,function(arg,datax)
if datax.type_.ID == "UserTypeDeleted" then 
NumMemDone = NumMemDone + 1
kick_user(v.user_id_,arg.ChatID,function(arg,data)  
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,v.user_id_)
redis:srem(boss..'whitelist:'..arg.ChatID,v.user_id_)
redis:srem(boss..'owners:'..arg.ChatID,v.user_id_)
redis:srem(boss..'admins:'..arg.ChatID,v.user_id_)
end)
end
NumMem = NumMem + 1
if NumMem == Total then
if NumMemDone >= 1 then
sendMsg(arg.ChatID,arg.MsgID,"⇠ ابشر طردد {* "..NumMemDone.." *} من الحسـابات المـحذوفه‏‏ ")
else
sendMsg(arg.ChatID,arg.MsgID,'⇠ مافيه حسابات محذوفه في المجموعه ')
end
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end  

if MsgText[1] == 'شحن' and MsgText[2] then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
if tonumber(MsgText[2]) > 0 and tonumber(MsgText[2]) < 1001 then
local extime = (tonumber(MsgText[2]) * 86400)
redis:setex(boss..'ExpireDate:'..msg.chat_id_, extime, true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'⇠ تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... 👍🏿')
sendMsg(SUDO_ID,0,'⇠ تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... 👍🏿\n⇠ في مجموعه  ↭ ↭  '..redis:get(boss..'group:name'..msg.chat_id_))
else
sendMsg(msg.chat_id_,msg.id_,'⇠ عزيزي المطور ✋🏿\n⇠ شحن الاشتراك يكون ما بين يوم الى 1000 يوم بس ')
end 
return false
end

if MsgText[1] == 'الاشتراك' and MsgText[2] then 
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
if MsgText[2] == '1' then
redis:setex(boss..'ExpireDate:'..msg.chat_id_, 2592000, true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'⇠ تم تفعيل الاشتراك   👍🏿\n⇠ الاشتراك ↭ `30 يوم`  *(شهر)*')
sendMsg(SUDO_ID,0,'⇠ تم تفعيل الاشتراك  👍🏿\n⇠ الاشتراك ↭ `30 يوم`  *(شهر)*')
end
if MsgText[2] == '2' then
redis:setex(boss..'ExpireDate:'..msg.chat_id_,7776000,true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'⇠ تم تفعيل الاشتراك   👍🏿\n⇠ الاشتراك ↭ `90 يوم`  *(3 اشهر)*')
sendMsg(SUDO_ID,0,'⇠ تم تفعيل الاشتراك   👍🏿\n⇠ الاشتراك ↭ `90 يوم`  *(3 اشهر)*')
end
if MsgText[2] == '3' then
redis:set(boss..'ExpireDate:'..msg.chat_id_,true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'⇠ تم تفعيل الاشتراك   👍🏿\n⇠ الاشتراك ↭ `مفتوح`  *(مدى الحياة)*')
sendMsg(SUDO_ID,0,'⇠ تم تفعيل الاشتراك   👍🏿\n⇠ الاشتراك ↭ `مفتوح`  *(مدى الحياة)*')
end 
return false
end

if MsgText[1] == 'الاشتراك' and not MsgText[2] and msg.Admin then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end
local check_time = redis:ttl(boss..'ExpireDate:'..msg.chat_id_)
if check_time < 0 then return '*مـفـتـوح * ' end
year = math.floor(check_time / 31536000)
byear = check_time % 31536000 
month = math.floor(byear / 2592000)
bmonth = byear % 2592000 
day = math.floor(bmonth / 86400)
bday = bmonth % 86400 
hours = math.floor( bday / 3600)
bhours = bday % 3600 
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if tonumber(check_time) > 1 and check_time < 60 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ * \n ⇠ '..sec..'* ثانيه'
elseif tonumber(check_time) > 60 and check_time < 3600 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ '..min..' *دقيقه و * *'..sec..'* ثانيه'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ * \n ⇠ '..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ * \n ⇠ '..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ * \n ⇠ '..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 31536000 then
remained_expire = '- `باقي من الاشتراك ` ↭ ↭ * \n ⇠ '..year..'* سنه و *'..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه' end
return remained_expire
end

if MsgText[1] == "الرتبه" and not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
GetChatMember(arg.ChatID,data.sender_user_id_,function(arg,data)
if data.status_ and data.status_.ID == "ChatMemberStatusEditor" then
SudoGroups = 'مشرف '
elseif data.status_ and data.status_.ID == "ChatMemberStatusCreator" then 
SudoGroups = "المالك"
else
SudoGroups = "عضو .!"
end

Getrtb = Getrtba(arg.UserID,arg.ChatID)
GetUserID(arg.UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERCAR  = utf8.len(USERNAME)
SendMention(arg.ChatID,arg.UserID,arg.MsgID,'( '..USERNAME..' )\n\n رتبتة : \n\n⇠ في البوت  '..arg.Getrtb..' \n⇠ في المجموعه  ( '..arg.SudoGroups..' )\n',14,utf8.len(USERNAME)) 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID,Getrtb=Getrtb,SudoGroups=SudoGroups})
end,{ChatID=arg.ChatID,UserID=data.sender_user_id_,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "كشف البوت" and not MsgText[2] then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
GetChatMember(msg.chat_id_,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusMember" then 
sendMsg(arg.ChatID,arg.MsgID,'- جيد , الـبــوت ادمــن الحين')
else 
sendMsg(arg.ChatID,arg.MsgID,'⇠ كلا البوت ليس ادمن في المجموعة ')
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false 
end

if MsgText[1]== 'رسائلي' or MsgText[1] == 'رسايلي' or MsgText[1] == 'احصائياتي'  then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info =  "⠀\n↫ ❪ احصائيات رسائلك ❫\n"
.."⇠ الـرسـائـل  ❪ `"..msgs.."`  ❫ \n"
.."⇠ الـجـهـات  ❪ `"..NumGha.."`  ❫ \n"
.."⇠ الـصـور  ❪ `"..photo.."`  ❫ \n"
.."⇠ الـمـتـحـركـه  ❪ `"..animation.."`  ❫ \n"
.."⇠ الـمـلـصـقات  ❪ `"..sticker.."`  ❫ \n"
.."⇠ الفويسات  ❪ `"..voice.."`  ❫ \n"
.."⇠ الـصـوت  ❪ `"..audio.."`  ❫ \n"
.."⇠ الـفـيـديـو  ❪ `"..video.."`  ❫ \n"
.."⇠ الـتـعـديـل  ❪ `"..edited.."`  ❫ \n\n"
.."⇠ تـفـاعـلـك   ❪  "..Get_Ttl(msgs).."  ❫ \n"
.."ـ.——————————\n"
return sendMsg(arg.chat_id_,arg.id_,Get_info)    
end,{chat_id_=msg.chat_id_,id_=msg.id_})
return false
end

if MsgText[1]== 'جهاتي' then
return '⇠ عدد جهاتك المـضـافه‏‏ ↭ 【'..(redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)..'】 .'
end

if MsgText[1] == 'معلوماتي' or MsgText[1] == 'موقعي' then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
USERNAME = ""
Name = data.first_name_
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ end
if data.username_ then USERNAME = "⇠ اليوزر  ‹  @["..data.username_.."]  › \n" end 
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = ""
else
SUDO_USERR = ""
end
local Get_info = "⇠ اهـلا بـك عيني في معلوماتك \n"
.."——————————\n"
.."⇠ الاســم  ❪  "..FlterName(Name,25) .." ❫ \n"
..USERNAME
.."⇠ الايـدي  ❪ `"..data.id_.."`  ❫ \n"
.."⇠ رتبتــك  ❪  "..arg.TheRank.."  ❫ \n"
.."⇠ ــ  ❪ `"..arg.chat_id_.."`  ❫ \n"
.."——————————\n"
.."  ❪ احـصـائـيـات الـرسـائـل  ❫ \n"
.."⇠ الـرسـائـل  ❪ `"..msgs.."`  ❫ \n"
.."⇠ الـجـهـات  ❪ `"..NumGha.."`  ❫ \n"
.."⇠ الـصـور  ❪ `"..photo.."`  ❫ \n"
.."⇠ الـمـتـحـركـه  ❪ `"..animation.."`  ❫ \n"
.."⇠ الـمـلـصـقات  ❪ `"..sticker.."`  ❫ \n"
.."⇠ الفويسات  ❪ `"..voice.."`  ❫ \n"
.."⇠ الـصـوت  ❪ `"..audio.."`  ❫ \n"
.."⇠ الـفـيـديـو  ❪ `"..video.."`  ❫ \n"
.."⇠ الـتـعـديـل  ❪ `"..edited.."`  ❫ \n\n"
.."⇠ تـفـاعـلـك   ❪  "..Get_Ttl(msgs).."  ❫ \n"
.."——————————\n"
..SUDO_USERR
sendMsg(arg.chat_id_,arg.id_,Get_info)    
end,{chat_id_=msg.chat_id_,id_=msg.id_,TheRank=msg.TheRank})
return false
end

if MsgText[1] == "تفعيل الردود العشوائيه" 	then return unlock_replayRn(msg) end
if MsgText[1] == "تفعيل الردود" 	then return unlock_replay(msg) end
if MsgText[1] == "تفعيل الايدي" 	then return unlock_ID(msg) end
if MsgText[1] == "تفعيل الترحيب" 	then return unlock_Welcome(msg) end
if MsgText[1] == "تفعيل التحذير" 	then return unlock_waring(msg) end 
if MsgText[1] == "تفعيل الايدي بالصوره" 	then return unlock_idphoto(msg) end 
if MsgText[1] == "تفعيل الحمايه" 	then return unlock_AntiEdit(msg) end 
if MsgText[1] == "تفعيل المغادره" 	then return unlock_leftgroup(msg) end 
if MsgText[1] == "تفعيل اطردني" 	then return unlock_leftgroup(msg) end 
if MsgText[1] == "تفعيل الحظر" 	then return unlock_KickBan(msg) end 
if MsgText[1] == "تفعيل الرابط" 	then return unlock_linkk(msg) end 
if MsgText[1] == "تفعيل المنشن" 	then return unlock_takkl(msg) end 
if MsgText[1] == "تفعيل التحقق" 		then return unlock_check(msg) end 
if MsgText[1] == "تفعيل التنظيف التلقائي" 		then return unlock_cleaner(msg) end 
if MsgText[1] == "تفعيل ردود السورس" 		then return unlock_rdodSource(msg) end 


if MsgText[1] == "تعطيل الردود العشوائيه" 	then return lock_replayRn(msg) end
if MsgText[1] == "تعطيل الردود" 	then return lock_replay(msg) end
if MsgText[1] == "تعطيل الايدي" 	then return lock_ID(msg) end
if MsgText[1] == "تعطيل الترحيب" 	then return lock_Welcome(msg) end
if MsgText[1] == "تعطيل التحذير" 	then return lock_waring(msg) end
if MsgText[1] == "تعطيل الايدي بالصوره" 	then return lock_idphoto(msg) end
if MsgText[1] == "تعطيل الحمايه" 	then return lock_AntiEdit(msg) end
if MsgText[1] == "تعطيل المغادره" 	then return lock_leftgroup(msg) end 
if MsgText[1] == "تعطيل اطردني" 	then return lock_leftgroup(msg) end 
if MsgText[1] == "تعطيل الحظر" 	then return lock_KickBan(msg) end 
if MsgText[1] == "تعطيل الرابط" 	then return lock_linkk(msg) end 
if MsgText[1] == "تعطيل المنشن" 	then return lock_takkl(msg) end 
if MsgText[1] == "تعطيل التحقق" 		then return lock_check(msg) end 
if MsgText[1] == "تعطيل التنظيف التلقائي" 		then return lock_cleaner(msg) end 
if MsgText[1] == "تعطيل ردود السورس" 		then return lock_rdodSource(msg) end 


if MsgText[1] == "ضع الترحيب" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
redis:set(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_,true) 
return [[
⇠ تمام عيني
- ارسل كليشه الترحيب الحين

- علما ان الاختصارات كالاتي : 

⇠ {الاسم} : لوضع اسم الحلو
⇠ {الايدي} : لوضع ايدي الحلو
⇠ {اليوزر} : لوضع معرف الحلو 
⇠ {الرتبه} : لوضع نوع رتبه الحلو 
⇠ {التفاعل} : لوضع تفاعل الحلو 
⇠ {الرسائل} : لاضهار عدد الرسائل 
⇠ {المجوهرات} : لاضهار عدد النقاط 
⇠ {التكليجات} : لاضهار عدد التكليجات 
⇠ {البوت} : لاضهار اسم البوت
⇠ {المطور} : لاضهار معرف Dev
⇠ {تعليق} : لاضهار ردود عشوائيه .

]]
end

if MsgText[1] == "الترحيب" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
if redis:get(boss..'welcome:msg'..msg.chat_id_)  then
return Flter_Markdown(redis:get(boss..'welcome:msg'..msg.chat_id_))
else 
return "⇠ اهلا عيني "..msg.TheRankCmd.."  \n⇠ نورت المجموعه " 
end 
end

if MsgText[1] == "المكتومين" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
return MuteUser_list(msg) 
end

if MsgText[1] == "المحظورين" then 
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
return GetListBanned(msg) 
end

if MsgText[1] == "رفع الادمنيه" then
if not msg.Creator then return "⇠ هذا الامر يخص ( المطور,المالك ) بس  \n" end
return set_admins(msg) 
end

end -- end of insert group 
if MsgText[1] == "تعطيل الاذاعه" 	then return lock_brod(msg) end
if MsgText[1] == "تفعيل تعيين الايدي"  	then return unlock_idediit(msg) end 
if MsgText[1] == "تعطيل تعيين الايدي"  	then return lock_idediit(msg) end 
if MsgText[1] == "تفعيل الاذاعه" then return unlock_brod(msg) end



if MsgText[1] == 'مسح المطورين'  then
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطورلاساسي ) بس  \n" end
local mtwren = redis:scard(boss..':SUDO_BOT:')
if mtwren == 0 then  return "⇠ معليش مافيه مطورين في البوت  ✖️" end
redis:del(boss..':SUDO_BOT:') 
return "⇠ تم مسحت {* "..mtwren.." *} من المطورين "
end

if MsgText[1] == 'مسح قائمه العام'  then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
local addbannds = redis:scard(boss..'gban_users')
if addbannds ==0 then 
return "⇠ قائمة الحظر فارغه ." 
end
redis:del(boss..'gban_users') 
return "⇠ تـم مـسـح { *"..addbannds.." *} من قائمه العام " 
end 
--=============================================================
--=============================================================
if MsgText[1] == "رفع مالك اساسي" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"⇠ معليش مقدر رفع بوت ") 
end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':Malk_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مالك اساسي من قبل في المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مالك اساسي في المجموعه") 
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..':Malk_Group:'..arg.ChatID,arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مالك اساسي من قبل \n𓍦") 
else
redis:hset(boss..'username:'..UserID,'username',arg.UserName)
redis:sadd(boss..':Malk_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مالك اساسي \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="UpMalk"})
end
return false
end

if MsgText[1] == "تنزيل مالك اساسي" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\]],"")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..':Malk_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مالك اساسي من قبل \n𓍦") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المالك الاساسي \n𓍦") 
redis:srem(boss..':Malk_Group:'..arg.ChatID,arg.UserID)
end  
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end

if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':Malk_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مالك اساسي من قبل \n𓍦") 
else
redis:srem(boss..':Malk_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المالك الاساسي \n𓍦")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 

if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwnMalk"}) 
end

return false
end

---=================================================================================
---=================================================================================

if MsgText[1] == "رفع مالك" or MsgText[1] == "رفع المالك" then
if not msg.Malk then return "⇠ هذا الامر يخص ( المطور,المالك اساسي) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"⇠ معليش مقدر رفع بوت ") 
end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مالك من قبل \n𓍦") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مالك \n𓍦") 
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"「 "..NameUser.." 」 \n⇠ مالك من قبل \n𓍦") 
else
redis:hset(boss..'username:'..UserID,'username',arg.UserName)
redis:sadd(boss..':MONSHA_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مالك \n𓍦") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="Upmonsh"}) 
end
return false
end

if MsgText[1] == "تنزيل مالك" or MsgText[1] == "تنزيل المالك" then
if not msg.Malk then return "⇠ هذا الامر يخص ( المطور,المالك اساسي) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\]],"")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مالك من قبل \n𓍦") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المالك \n𓍦") 
redis:srem(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID)
end  
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مالك من قبل \n𓍦") 
else
redis:srem(boss..':MONSHA_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من المالك \n𓍦")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 

if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="Dwmonsh"}) 
end

return false
end


if MsgText[1] == 'مسح كلايش التعليمات' then 
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:del(boss..":awamer_Klesha_m1:")
redis:del(boss..":awamer_Klesha_m2:")
redis:del(boss..":awamer_Klesha_m3:")
redis:del(boss..":awamer_Klesha_mtwr:")
redis:del(boss..":awamer_Klesha_mrd:")
redis:del(boss..":awamer_Klesha_mf:")
redis:del(boss..":awamer_Klesha_m:")

sendMsg(msg.chat_id_,msg.id_,"⇠ تم مسحت كلايش التعليمات  \n")
end

if MsgText[1] == 'مسح كليشه الايدي' or MsgText[1] == 'مسح الايدي' or MsgText[1] == 'مسح ايدي'  or MsgText[1] == 'مسح كليشة الايدي'  then 
if not msg.Creator then return "⇠ هذا الامر يخص {مالك,المنشئ,المطور ) بس  \n" end
redis:del(boss..":infoiduser_public:"..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم مسحت الايدي  \n")
end

if MsgText[1] == 'تعيين كليشه الايدي' or MsgText[1] == 'تعيين الايدي' or MsgText[1] == 'تعيين ايدي'  or MsgText[1] == 'تعيين كليشة الايدي'  then 
if not msg.Creator then return "⇠ هذا الامر يخص {مالك,المنشئ,المطور ) بس  \n" end
redis:setex(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '⇠ تمام, الحين ارسل كليشه الايدي الجديده \n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم الحلو\n{الايدي} : لوضع ايدي الحلو\n{اليوزر} : لوضع يوزر الحلو \n{الرتبه} : لوضع نوع رتبه الحلو \n{التفاعل} : لوضع تفاعل الحلو \n{الرسائل} : لاضهار عدد الرسائل \n{المجوهرات} : لاضهار عدد النقاط \n{التكليجات} : لاضهار عدد التكليجات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف Dev\n{البايو} : لوضع البايو\n قناه تعليمات ونشر كلايش الايدي \n{تعليق} : لاضهار ردود عشوائيه .\n قناه الكلايش : [@rnnni] \n' 
end


if MsgText[1] == "تنزيل الكل" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المنشئ,المطور ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات") end
local UserID = data.sender_user_id_
msg = arg.msg
msg.UserID = UserID
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
msg = arg.msg
UserID = msg.UserID
if UserID == our_id then return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تنفيذ الامر مع البوت\n") end
if UserID == 1419573259 or UserID == 1419573259 then return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تنزل مطور الاساسي! \n") end

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':Malk_Group:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
rinkuser = 7
elseif redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then 
rinkuser = 8
else
rinkuser = 9
end
local DonisDown = "\n⇠ ابشر نزلتهه من الرتب الاتيه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."⇠  المطور \n"
end 
if redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المالك \n"
end 
if redis:sismember(boss..':Malk_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المالك اساسي \n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المنشئ \n"
end 
if redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المدير \n"
end 
if redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  الادمن \n"
end 
if redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then
DonisDown = DonisDown.."⇠  الحلو مميز \n"
end
function senddwon() sendMsg(msg.chat_id_,msg.id_,"⇠ رتبته اعلى منك هييه مايمديك تنزله! ") end
function sendpluse() sendMsg(msg.chat_id_,msg.id_,"⇠ معليش مقدر تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." ") end

if rinkuser == 9 then return sendMsg(msg.chat_id_,msg.id_,"⇠ الحلو「 "..NameUser.." 」   \nهذا عضو من قبل ")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':Malk_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':Malk_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Malk then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SuperCreator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 4 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Creator then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Director then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Admin then 
if rinkuser == 7 then return sendpluse() end
if rinkuser < 7 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
else
huk = true
end

if not huk then sendMsg(msg.chat_id_,msg.id_,"⇠ الحلو「 "..NameUser.." 」 \n"..DonisDown.."\n️") end

end,{msg=msg})
end,{msg=msg})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(msg.chat_id_,msg.id_,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(msg.chat_id_,msg.id_,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
if UserID == our_id then return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تنفيذ الامر مع البوت ") end

msg = arg.msg
if UserID == 1419573259 or UserID == 1419573259 then return sendMsg(msg.chat_id_,msg.id_,"⇠ هييه مايمديك تنزل مطور! ") end
NameUser = Hyper_Link_Name(data)

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':Malk_Group:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
rinkuser = 7
elseif redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then 
rinkuser = 8
else
rinkuser = 9
end
local DonisDown = "\n⇠ ابشر نزلتهه من الرتب الاتيه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."⇠  المطور \n"
end 
if redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المالك \n"
end 
if redis:sismember(boss..':Malk_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المالك اساسي \n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المنشئ \n"
end 
if redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  المدير \n"
end 
if redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."⇠  الادمن \n"
end 
if redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then
DonisDown = DonisDown.."⇠  الحلو مميز \n"
end

function senddwon() sendMsg(msg.chat_id_,msg.id_,"⇠ رتبته اعلى منك هييه مايمديك تنزله! ") end
function sendpluse() sendMsg(msg.chat_id_,msg.id_,"⇠ معليش مقدر تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." ") end

if rinkuser == 9 then return sendMsg(msg.chat_id_,msg.id_,"⇠ الحلو「 "..NameUser.." 」   \nهذا عضو من قبل ️")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':Malk_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':Malk_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Malk then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SuperCreator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 4 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Creator then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Director then 
if rinkuser ==6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Admin then 
if rinkuser == 7 then return sendpluse() end
if rinkuser < 7 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
else
huk = true
end

if not huk then sendMsg(msg.chat_id_,msg.id_,"⇠ الحلو「 "..NameUser.." 」 \n"..DonisDown.."\n️") end

end,{msg=msg})
end 

if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwnAll"}) 
end

return false
end



--=====================================================================================


if MsgText[1] == "قائمه الاوامر" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local list = redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
local list2 = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
message = "⇠ الاوامر الجديد : \n\n" i = 0
for name,Course in pairs(list) do i = i + 1 message = message ..i..' ⇠ *{* '..name..' *}* ~> '..Course..' \n'  end 
if i == 0 then return "⇠ لا توجد اوامر مضافه في القائمه \n " end
return message
end


if MsgText[1] == "مسح الاوامر" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المنشئ,المدير ) بس  \n" end
local Awammer 	= redis:del(boss..":AwamerBot:"..msg.chat_id_)
redis:del(boss..":AwamerBotArray:"..msg.chat_id_)
redis:del(boss..":AwamerBotArray2:"..msg.chat_id_)
if Awammer ~= 0 then
return "⇠ تم مسحت قائمه الاوامر"
else
return "⇠ القائمه بالفعل ممسوحه \n"
end
end


if MsgText[1] == "تعيين امر" or MsgText[1] == "تعين امر" or MsgText[1] == "اضف امر" or MsgText[1] == "تغير امر" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
if MsgText[2] then

local checkAmr = false
for k, Boss in pairs(XBoss) do if MsgText[2]:match(Boss) then  checkAmr = true end end      
if checkAmr then
redis:setex(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_,300,MsgText[2])
return "⇠ تمام عزيزي , لتغير امر {* "..MsgText[2].." *} ارسل الامر الجديد الحين"
else
return "⇠ معليش مافيه هذا الامر في البوت لتتمكن من تغييره  \n"
end
else
redis:setex(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام عزيزي , لتغير امر ارسل الامر القديم الحين"
end
end

if MsgText[1] == "مسح امر"  then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
if MsgText[2] then
local checkk = redis:hdel(boss..":AwamerBotArray2:"..msg.chat_id_,MsgText[2])
local AmrOld = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
amrnew = ""
amrold = ""
amruser = MsgText[2].." @user"
amrid = MsgText[2].." 23434"
amrklma = MsgText[2].." ffffff"
amrfile = MsgText[2].." fff.lua"
for Amor,ik in pairs(AmrOld) do
if MsgText[2]:match(Amor) then			
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amruser:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrid:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrklma:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrfile:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
end
end
if checkk ~=0 then
return "⇠ تم مسحت الامر {* "..MsgText[2].." *} من قائمه الاومر "
else
return "⇠ هذا الامر مو موجود اصلا \n"
end
else
redis:setex(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام، ارسل الامر الي تبي تمسحه"
end


end


--=====================================================================================


if msg.SudoBase then

if MsgText[1] == "نقل ملكيه البوت"  then
redis:setex(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام عيني\n⇠ الحين ارسل معرف الحلو لنقل ملكية البوت له ."
end





if MsgText[1] == 'تعيين قائمه الاوامر' then 
redis:setex(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '⇠ ارسل امر القائمه المراد تعيينهم مثل الاتي "\n꒐`م1` , `م2 `, `م3 `, `م4 ` , `م6 `,  `م5` \n' 
end


if MsgText[1] == "رفع مطور" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات ") end
local UserID = data.sender_user_id_
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"⇠ معليش ما اقدر ارفع بوت ") 
end
GetUserID(UserID,function(arg,data)
RUSERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':SUDO_BOT:',arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مطور من قبل في البوت") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ايشر رفعته صار مطور") 
redis:hset(boss..'username:'..arg.UserID,'username',RUSERNAME)
redis:sadd(boss..':SUDO_BOT:',arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
ReUsername = arg.UserName
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مطور من قبل في البوت") 
else
redis:hset(boss..'username:'..UserID,'username',ReUsername)
redis:sadd(boss..':SUDO_BOT:',UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر رفعته صار مطور") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 


if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="up_sudo"}) 
end
return false
end

if MsgText[1] == "تنزيل مطور" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات ") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':SUDO_BOT:',arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مطور من قبل \n𓍦") 
else
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلته من مطور") 
redis:srem(boss..':SUDO_BOT:',arg.UserID)
end  
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
--================================================
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':SUDO_BOT:',UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو مطور من قبل \n𓍦") 
else
redis:srem(boss..':SUDO_BOT:',UserID)
sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ ابشر نزلتهه مطور") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="dn_sudo"}) 
end
return false
end

if MsgText[1] == "تنظيف المجموعات" then
local groups = redis:smembers(boss..'group:ids')
local GroupsIsFound = 0
for i = 1, #groups do 
GroupTitle(groups[i],function(arg,data)
if data.code_ and data.code_ == 400 then
rem_data_group(groups[i])
print(" Del Group From list ")
else
print(" Name Group : "..data.title_)
GroupsIsFound = GroupsIsFound + 1
end
print(GroupsIsFound..' : '..#groups..' : '..i)
if #groups == i then
local GroupDel = #groups - GroupsIsFound 
if GroupDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'- جـيـد , لا توجد مجموعات وهميه \n')
else
sendMsg(msg.chat_id_,msg.id_,'⇠ عدد المجموعات  ‹ *'..#groups..'*   › \n⇠ تـم تنظيف   ‹ *'..GroupDel..'*   ›  مجموعه \n⇠ اصبح العدد الحقيقي الحين  ‹ *'..GroupsIsFound..'*   ›  مجموعه')
end
end
end)
end
return false
end
if MsgText[1] == "تنظيف المشتركين" then
local pv = redis:smembers(boss..'users')
local NumPvDel = 0
for i = 1, #pv do
GroupTitle(pv[i],function(arg,data)
sendChatAction(pv[i],"Typing",function(arg,data)
if data.ID and data.ID == "Ok"  then
print("Sender Ok")
else
print("Failed Sender Nsot Ok")
redis:srem(boss..'users',pv[i])
NumPvDel = NumPvDel + 1
end
if #pv == i then 
if NumPvDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'- جـيـد , مافيه مشتركين وهمي')
else
local SenderOk = #pv - NumPvDel
sendMsg(msg.chat_id_,msg.id_,'⇠ عدد المشتركين  ‹ *'..#pv..'*   › \n⇠ تـم تنظيف   ‹ *'..NumPvDel..'*   ›  مشترك \n⇠ اصبح العدد الحقيقي الحين  ‹ *'..SenderOk..'*   ›  من المشتركين') 
end
end
end)
end)
end
return false
end
if MsgText[1] == "ضع صوره للترحيب" then
redis:setex(boss..'welcom_ph:witting'..msg.sender_user_id_..msg.chat_id_,300,true) 
return'⇠ تمام عيني \n⇠ الحين قم بارسال الصوره للترحيب ' 
end

if MsgText[1] == "تعطيل البوت خدمي"  then 
return lock_service(msg) 
end

if MsgText[1] == "تفعيل البوت خدمي"  then 
return unlock_service(msg) 
end

if MsgText[1] == "صوره الترحيب" then
local Photo_Weloame = redis:get(boss..':WELCOME_BOT')
if Photo_Weloame then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "- مـعرف المـطـور  ↭ "..SUDO_USER.." "
else
SUDO_USERR = ""
end
sendPhoto(msg.chat_id_,msg.id_,Photo_Weloame,[[- مـرحبا انا بوت اسـمـي ]]..redis:get(boss..':NameBot:')..[[ 🎖
- اختصـاصـي حمـايه‏‏ المـجمـوعات
- مـن السـبام والتوجيه‏‏ والتكرار والخ...
]]..SUDO_USERR) 
return false
else
return "⇠ لا توجد صوره مضافه للترحيب في البوت \n⇠ لاضافه صوره الترحيب ارسل `ضع صوره للترحيب`"
end
end

if MsgText[1] == "ضع كليشه المطور" then 
redis:setex(boss..'text_sudo:witting'..msg.sender_user_id_,1200,true) 
return '⇠ تمام عزيزي \n⇠ الحين قم بارسال الكليشه' 
end

if MsgText[1] == "مسح كليشه المطور" then 
if not redis:get(boss..":TEXT_SUDO") then
return '⇠ مافيه كليشه مطور اساساً' end
redis:del(boss..':TEXT_SUDO') 
return '⇠ اهلا عيني '..msg.TheRank..'\n⇠ ابشر مسحت كليشه المطور ' 
end

if MsgText[1] == "ضع كليشه السورس" then 
  redis:setex(boss..'text_sudo1:witting'..msg.sender_user_id_,1200,true) 
  return '⇠ تمام عزيزي \n⇠ الحين قم بارسال الكليشه' 
  end
  
  if MsgText[1] == "مسح كليشه السورس" then 
  if not redis:get(boss..":TEXT_SUDO1") then
  return '⇠ مافيه كليشه السورس اساساً' end
  redis:del(boss..':TEXT_SUDO1') 
  return '⇠ اهلا عيني '..msg.TheRank..'\n⇠ ابشر مسحت كليشه السورس ' 
  end


if MsgText[1] == "ضع شرط التفعيل" and MsgText[2] and MsgText[2]:match('^%d+$') then 
redis:set(boss..':addnumberusers',MsgText[2]) 
return '⇠ ابشر وضعت شـرط التفعيل البوت اذا كانت المجموعه‏‏ اكثر مـن *【'..MsgText[2]..'】* عضـو  \n' 
end

if MsgText[1] == "شرط التفعيل" then 
return'- شـرط التفعيل البوت اذا كانت المجموعه‏‏ اكثر مـن *【'..redis:get(boss..':addnumberusers')..'】* عضـو  \n' 
end 
end

if MsgText[1] == 'المجموعات' or MsgText[1] == "المجموعات 🔝" then 
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
return '⇠ عدد المجموعات المفعلة ↭ `'..redis:scard(boss..'group:ids')..'`  ' 
end

if MsgText[1] == 'مسح كليشه الايدي عام' or MsgText[1] == 'مسح الايدي عام' or MsgText[1] == 'مسح ايدي عام'  or MsgText[1] == 'مسح كليشة الايدي عام' or MsgText[1] == 'مسح كليشه الايدي عام' then 
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss.."lockidedit") then return "⇠ الامر معطل من قبل مطور الاساسي  \n" end
redis:del(boss..":infoiduser")
return sendMsg(msg.chat_id_,msg.id_,"⇠ ابشر مسحت كليشة الايدي العام  ")
end

if MsgText[1] == 'تعيين كليشه الايدي عام' or MsgText[1] == 'عام تعيين الايدي' or MsgText[1] == 'تعيين ايدي عام'  or MsgText[1] == 'تعيين كليشة الايدي عام'  or MsgText[1] == 'تعيين كليشه الايدي عام' then 
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss.."lockidedit") then return "⇠ تعيين الايدي معطل من قبل مطور الاساسي  \n" end
redis:setex(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '⇠ تمام, الحين ارسل كليشه الايدي الجديده \n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم الحلو\n{الايدي} : لوضع ايدي الحلو\n{اليوزر} : لوضع معرف الحلو \n{الرتبه} : لوضع نوع رتبه الحلو \n{التفاعل} : لوضع تفاعل الحلو \n{الرسائل} : لاضهار عدد الرسائل \n{المجوهرات} : لاضهار عدد النقاط \n{التكليجات} : لاضهار عدد التكليجات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف Dev\n{البايو} : لوضع البايو\n قناه تعليمات ونشر كلايش الايدي \n{تعليق} : لاضهار ردود عشوائيه .\n قناه الكلايش : [@rnnni] \n' 
end


if MsgText[1] == 'قائمه المجموعات' then 
if not msg.SudoBase then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
return chat_list(msg) 
end


if MsgText[1] == 'تعطيل' and MsgText[2] and MsgText[2]:match("(%d+)") then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
local idgrup = "-100"..MsgText[2]
local name_gp = redis:get(boss..'group:name'..idgrup)
GroupTitle(idgrup,function(arg,data)
if data.ID and data.ID == "Error" and data.message_ == "CHANNEL_INVALID" then
if redis:sismember(boss..'group:ids',arg.Group) then
rem_data_group(arg.Group)
sendMsg(arg.chat_id_,arg.id_,'⇠ البوت ليس بالمجموعة ولكن تم مسحت بياناتها \n⇠ المجموعةة ↭ ['..arg.name_gp..']\n⇠ الايدي ↭ ( *'..arg.Group..'* ) ')
else 
sendMsg(arg.chat_id_,arg.id_,'⇠ البوت ليس مفعل بالمجموعه \n⇠ ومافيه بيانات لها ️')
end
else
StatusLeft(arg.Group,our_id)
if redis:sismember(boss..'group:ids',arg.Group) then
sendMsg(arg.Group,0,'⇠ تم تعطيل المجموعه بامر من المطور  \n⇠ سوف اغادر جاوو ... ✘')
rem_data_group(arg.Group)
sendMsg(arg.chat_id_,arg.id_,'⇠ تم تعطيل المجموعه ومغادرتها \n⇠ المجموعةة ↭ ['..arg.name_gp..']\n⇠ الايدي ↭ ( *'..arg.Group..'* ) ')
else 
sendMsg(arg.chat_id_,arg.id_,'⇠ البوت ليس مفعل بالمجموعة \n⇠ ولكن تم مغادرتها\n⇠ المجموعةة ↭ ['..arg.name_gp..'] ')
end
end 
end,{chat_id_=msg.chat_id_,id_=msg.id_,Group=idgrup,name_gp=name_gp})
return false
end

if MsgText[1] == 'المطور' then
GetUserID(SUDO_ID,function(arg,data)
local SUDO_NAME = '['..Flter_Markdown(data.first_name_..' '..(data.last_name_ or ""))..'](tg://user?id='..SUDO_ID..')'
return send_msg(msg.chat_id_,redis:get(boss..":TEXT_SUDO") or SUDO_NAME,msg.id_)
end,nil)
end

if MsgText[1] == 'السورس' or  MsgText[1] == 'سورس البوت' or  MsgText[1] == 'سورس' then
GetUserID(SUDO_ID,function(arg,data)
local SUDO_NAME = '['..Flter_Markdown(data.first_name_..' '..(data.last_name_ or ""))..'](tg://user?id='..SUDO_ID..')'
return send_msg(msg.chat_id_,redis:get(boss..":TEXT_SUDO1") or SUDO_NAME,msg.id_)
end,nil)
end


if MsgText[1] == "اذاعه بالتثبيت" then
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
return "⇠ تمام الحين ارسل رساله ليتم اذاعتها بالتثبيت " 
end

if MsgText[1] == "اذاعه عام بالتوجيه"  then
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "⇠ الاذاعه مقفوله من قبل مطور الاساسي  " 
end
redis:setex(boss..'fwd:'..msg.sender_user_id_,300, true) 
return "⇠ تمام الحين ارسل التوجيه للاذاعه " 
end

if MsgText[1] == "اذاعه عام"  then		
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "⇠ الاذاعه مقفوله من قبل مطور الاساسي" 
end
redis:setex(boss..'fwd:all'..msg.sender_user_id_,300, true) 
return "⇠ تمام الحين ارسل الكليشه للاذاعه عام" 
end

if MsgText[1] == "اذاعه خاص" then	
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "⇠ الاذاعه مقفوله من قبل مطور الاساسي" 
end
redis:setex(boss..'fwd:pv'..msg.sender_user_id_,300, true) 
return "⇠ تمام الحين ارسل الكليشه للاذاعه خاص"
end

if MsgText[1] == "اذاعه"  then	
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "⇠ الاذاعه مقفوله من قبل مطور الاساسي" 
end
redis:setex(boss..'fwd:groups'..msg.sender_user_id_,300, true) 
return "⇠ تمام الحين ارسل الكليشه للاذاعه للمجموعات " 
end

if MsgText[1] == "المطورين"  then
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
return sudolist(msg) 
end

if MsgText[1] == "قائمه العام"  then 
if not msg.SudoUser then return"⇠ هذا الامر يخص ( المطور ) بس  \n" end
return GetListGeneralBanned(msg) 
end

if MsgText[1] == "تعطيل التواصل"  then 
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
return lock_twasel(msg) 
end

if MsgText[1] == "تفعيل التواصل"  then 
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطورالاساسي ) بس  \n" end
return unlock_twasel(msg) 
end

if MsgText[1] == "حظر عام" then
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات ") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر البوت ") 
elseif  UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور السورس ")
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور الاساسي ")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المطور ") 
end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if GeneralBanned(arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ محظور عام من قبل في المجموعات ") 
else
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'gban_users',arg.UserID)
kick_user(arg.UserID,arg.ChatID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ حظرته عام الهطف ") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر البوت ") 
elseif  UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور السورس ")
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور الاساسي ")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر المطور ") 
end
if redis:sismember(boss..'gban_users',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ محظور عام من قبل في المجموعات ") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'gban_users',UserID)
kick_user(UserID,arg.ChatID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ حظرته عام الهطف ") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="bandall"}) 
end
return false
end

if MsgText[1] == "الغاء العام" or MsgText[1] == "الغاء عام" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( المطور الاساسي ) بس  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحلو ليس موجود ضمن المجموعات ") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if GeneralBanned(arg.UserID) then 
redis:srem(boss..'gban_users',arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو محظور عام من قبل في المجموعات ") 
else
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغاء حظره العام  من المجموعات ") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.reply_id})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unbandall"}) 
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") end
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'gban_users',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ مو محظور عام من قبل في المجموعات ") 
else
redis:srem(boss..'gban_users',UserID)
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغاء حظره العام  من المجموعات ") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
return false
end 

if MsgText[1] == "رتبتي" then return 'رتبتك ↭ '..msg.TheRank..'' end

----------------- استقبال الرسائل ---------------
if MsgText[1] == "الغاء الامر" or MsgText[1] == "الغاء" then
if not msg.Admin then return "⇠ هذا الامر يخص ( الادمن,المدير,المالك,المطور ) بس  \n" end
redis:del(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'name:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'about:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'fwd:all'..msg.sender_user_id_,
boss..'fwd:pv'..msg.sender_user_id_,
boss..'fwd:groups'..msg.sender_user_id_,
boss..'namebot:witting'..msg.sender_user_id_,
boss..'addrd_all:'..msg.sender_user_id_,
boss..'delrd:'..msg.sender_user_id_,
boss..'addrd:'..msg.sender_user_id_,
boss..'delrdall:'..msg.sender_user_id_,
boss..'text_sudo:witting'..msg.sender_user_id_,
boss..'text_sudo1:witting'..msg.sender_user_id_,
boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_,
boss..'addrd:'..msg.chat_id_..msg.sender_user_id_,
boss..':KStart:'..msg.chat_id_..msg.sender_user_id_,
boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_,
boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_,
boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_,
boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_,
boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_,
boss..":ForceSub:"..msg.sender_user_id_,
boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_,
boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom1:'..msg.sender_user_id_,
boss..'addrdRandom:'..msg.sender_user_id_,
boss..'replay1Random'..msg.sender_user_id_)

return '⇠ تم الغيت الامر  '
end  

if (MsgText[1] == '/files' or MsgText[1]== "الملفات"  ) then
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
return All_File()
end   


if MsgText[1] == 'اصدار السورس' or MsgText[1] == 'الاصدار' then
return '⇠ اصدار سورس YxY : *v'..version..'* '
end

if MsgText[1] == 'تحديث السورس' then
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
local GetVerison = https.request('https://alyafae.github.io/GetVersion.txt') or "0"
GetVerison = GetVerison:gsub("\n",""):gsub(" ","")
if GetVerison > version then
UpdateSourceStart = true
sendMsg(msg.chat_id_,msg.id_,'- يوجد تحديث جديد الحين \n⇠ جاري تنزيل وتثبيت التحديث  ...')
redis:set(boss..":VERSION",GetVerison)
return false
else
return "⇠ الاصدار الحالي : *v"..version.."* \n⇠ لديـك احدث اصدار "
end
return false
end


if MsgText[1] == 'نسخه احتياطيه للمجموعات' then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور السورس ) بس  \n" end
return buck_up_groups(msg)
end 

if MsgText[1] == 'رفع نسخه الاحتياطيه' then
if not msg.SudoBase then return "⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessageDocument' then
local file_name = data.content_.document_.file_name_
if file_name:match('.json')then
if file_name:match('@[%a%d_]+.json') then
if file_name:lower():match('@[%a%d_]+') == Bot_User:lower() then 
io.popen("rm -f ../.telegram-cli/data/document/*")
local file_id = data.content_.document_.document_.id_ 
tdcli_function({ID = "DownloadFile",file_id_ = file_id},function(arg, data) 
if data.ID == "Ok" then
Uploaded_Groups_Ok = true
Uploaded_Groups_CH = arg.chat_id_
Uploaded_Groups_MS = arg.id_
print(Uploaded_Groups_CH)
print(Uploaded_Groups_MS)
sendMsg(arg.chat_id_,arg.id_,'- جاري رفع النسخه انتظر قليلا ... ')
end
end,{chat_id_=arg.chat_id_,id_=arg.id_})
else 
sendMsg(arg.chat_id_,arg.id_,"⇠ معليش النسخه الاحتياطيه هذا ليست للبوت ↭ ["..Bot_User.."] ")
end
else 
sendMsg(arg.chat_id_,arg.id_,'⇠ معليش اسم الملف غير مدعوم للنظام او لا يتوافق مع سورس YxY يرجى جلب الملف الاصلي الذي قمت بسحبه وبدون تعديل ع الاسم ')
end  
else
sendMsg(arg.chat_id_,arg.id_,'⇠ معليش الملف ليس بصيغه Json !? ')
end 
else
sendMsg(arg.chat_id_,arg.id_,'⇠ معليش هذا ليس ملف النسحه الاحتياطيه للمجموعات ')
end 
end,{chat_id_=msg.chat_id_,id_=msg.id_})
else 
return "⇠ ارسل ملف النسخه الاحتياطيه اولا\n⇠ ثم قم بالرد على الملف وارسل \" `رفع نسخه الاحتياطيه` \" "
end 
return false
end

if (MsgText[1]=="تيست" or MsgText[1]=="test") then 
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
return " تم " 
end

if (MsgText[1]== "ايديي" or MsgText[1]=="ايدي") and msg.type == "pv" then return  "\n"..msg.sender_user_id_.."\n"  end

if MsgText[1]== "قناة السورس" and msg.type == "pv" then
local inline = {{{text="مياو",url="https://t.me/Ezabella"}}}
send_key(msg.sender_user_id_,'  [قناة السورس: YxY](t.me/Ezabella)',nil,inline,msg.id_)
return false
end

if MsgText[1]== "الاحصائيات" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
return 'الاحصائيات  \n\n⇠ عدد المجموعات المفعله : '..redis:scard(boss..'group:ids')..'\n⇠ عدد المشتركين في البوت : '..redis:scard(boss..'users')..' '
end
---------------[End Function data] -----------------------
if MsgText[1]=="اضف رد عام" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:setex(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_,300,true)
redis:del(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
return "⇠ تمام الحين ارسل كلمة الرد العام "
end

---------------[End Function data] -----------------------
if MsgText[1] == "تعيين كليشه الستارت" or MsgText[1] == "تعيين كليشة الستارت"  then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( Dev ) بس  \n" end
redis:setex(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_,900,true)
return "⇠ تمام الحين ارسل كليشة الستارت \n\n⇠ علما ان الاختصارات كالاتي : \n \n⇠ {الاسم} : لوضع اسم الحلو\n⇠ {الايدي} : لوضع ايدي الحلو\n⇠ {اليوزر} : لوضع معرف الحلو \n⇠ {الرتبه} : لوضع نوع رتبه الحلو \n⇠ {البوت} : لاضهار اسم البوت \n⇠ {المطور} : لاضهار معرف Dev .\n⇠ {تعليق} : لاضهار ردود عشوائيه ."
end
if MsgText[1] == "مسح كليشه الستارت" or MsgText[1] == "مسح كليشة الستارت"  then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:del(boss..':Text_Start')
return "⇠ ابشر مسحت كليشه الستارت "
end

if MsgText[1]== 'مسح' and MsgText[2]== 'الردود' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
local names 	= redis:exists(boss..'replay:'..msg.chat_id_)
local photo 	= redis:exists(boss..'replay_photo:group:'..msg.chat_id_)
local voice 	= redis:exists(boss..'replay_voice:group:'..msg.chat_id_)
local imation   = redis:exists(boss..'replay_animation:group:'..msg.chat_id_)
local audio	 	= redis:exists(boss..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:exists(boss..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:exists(boss..'replay_video:group:'..msg.chat_id_)
local file 	= redis:exists(boss..'replay_files:group:'..msg.chat_id_)
if names or photo or voice or imation or audio or sticker or video or file then
redis:del(boss..'replay:'..msg.chat_id_,boss..'replay_photo:group:'..msg.chat_id_,boss..'replay_voice:group:'..msg.chat_id_,
boss..'replay_animation:group:'..msg.chat_id_,boss..'replay_audio:group:'..msg.chat_id_,boss..'replay_sticker:group:'..msg.chat_id_,boss..'replay_video:group:'..msg.chat_id_,boss..'replay_files:group:'..msg.chat_id_)
return " تم مسحت كل الردود"
else
return '⇠ مافيه ردود ليتم مسحتها \n'
end
end

if MsgText[1] == 'مسح' and MsgText[2] == 'الردود العامه' then
if not msg.SudoBase then return" للمطورين بس " end
local names 	= redis:exists(boss..'replay:all')
local photo 	= redis:exists(boss..'replay_photo:group:')
local voice 	= redis:exists(boss..'replay_voice:group:')
local imation 	= redis:exists(boss..'replay_animation:group:')
local audio 	= redis:exists(boss..'replay_audio:group:')
local sticker 	= redis:exists(boss..'replay_sticker:group:')
local video 	= redis:exists(boss..'replay_video:group:')
local file 	= redis:exists(boss..'replay_files:group:')
if names or photo or voice or imation or audio or sticker or video or file then
redis:del(boss..'replay:all',boss..'replay_photo:group:',boss..'replay_voice:group:',boss..'replay_animation:group:',boss..'replay_audio:group:',boss..'replay_sticker:group:',boss..'replay_video:group:',boss..'replay_files:group:')
return " ابشر مسحت كل الردود العامه"
else
return "مافيه ردود عامه ليتم مسحتها ! "
end
end

if MsgText[1]== 'مسح' and MsgText[2]== 'رد عام' then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:set(boss..'delrdall:'..msg.sender_user_id_,true) 
return "⇠ تمام عيني\n⇠ الحين ارسل الرد لمسحه من المجموعات"
end

if MsgText[1]== 'مسح' and MsgText[2]== 'رد' then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
redis:set(boss..'delrd:'..msg.sender_user_id_,true)
return "⇠ تمام عيني\n⇠ الحين ارسل الرد عشان امسحه"
end

if MsgText[1]== 'الردود' then

if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
local names  	= redis:hkeys(boss..'replay:'..msg.chat_id_)
local photo 	= redis:hkeys(boss..'replay_photo:group:'..msg.chat_id_)
local voice  	= redis:hkeys(boss..'replay_voice:group:'..msg.chat_id_)
local imation 	= redis:hkeys(boss..'replay_animation:group:'..msg.chat_id_)
local audio 	= redis:hkeys(boss..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:hkeys(boss..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:hkeys(boss..'replay_video:group:'..msg.chat_id_)
local files 	= redis:hkeys(boss..'replay_files:group:'..msg.chat_id_)
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 and #files==0  then 
return '⇠ مافيه ردود مضافه حاليا ' 
end
local ii = 1
local message = '- ردود البوت في المجموعه  :\n\n'
for i=1, #photo 	do message = message ..ii..' ⇠ *❨* '..	photo[i]..' *❩ _ *❨ صوره ❩ \n' 	 ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' ⇠ *❨* '..	names[i]..' *❩ _ *❨ نص❩ \n'  	 ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' ⇠ *❨* '..  voice[i]..' *❩ _ *❨ بصمه❩ \n' 	 ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' ⇠ *❨* '..imation[i]..' *❩ _ *❨ متحركه❩ \n' ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' ⇠ *❨* '..	audio[i]..' *❩ _ *❨ صوتيه❩ \n'  ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' ⇠ *❨* '..sticker[i]..' *❩ _ *❨ ملصق❩ \n' 	 ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' ⇠ *❨* '..	video[i]..' *❩ _ *❨ فيديو❩ \n' ii = ii + 1 end
for i=1, #files 	do message = message ..ii..' ⇠ *❨* '..	files[i]..' *❩ _ *❨ ملف❩ \n' ii = ii + 1 end
message = message..'\n𓍦'
if utf8.len(message) > 4096 then
return "⇠ مقدر عرض الردود عشان القائمه كبيره جدا ."
else
return message
end
end

if MsgText[1]== 'الردود العامه' then
if not msg.SudoBase then return " للمطور بس " end
local names 	= redis:hkeys(boss..'replay:all')
local photo 	= redis:hkeys(boss..'replay_photo:group:')
local voice 	= redis:hkeys(boss..'replay_voice:group:')
local imation 	= redis:hkeys(boss..'replay_animation:group:')
local audio 	= redis:hkeys(boss..'replay_audio:group:')
local sticker 	= redis:hkeys(boss..'replay_sticker:group:')
local video 	= redis:hkeys(boss..'replay_video:group:')
local files 	= redis:hkeys(boss..'replay_files:group:')
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 and #files==0 then 
return '⇠ مافيه ردود مضافه حاليا ' 
end
local ii = 1
local message = '⇠ الردود العامه في البوت :   :\n\n'
for i=1, #photo 	do message = message ..ii..' ⇠ *❨* '..	photo[i]..' *❩ _ *❨ صوره ❩ \n' 	ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' ⇠ *❨* '..	names[i]..' *❩ _ *❨ نص❩ \n'  	ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' ⇠ *❨* '..	voice[i]..' *❩ _ *❨ بصمه❩ \n' 	ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' ⇠ *❨* '..imation[i]..' *❩ _ *❨ متحركه❩ \n'ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' ⇠ *❨* '..	audio[i]..' *❩ _ *❨ صوتيه❩ \n' ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' ⇠ *❨* '..sticker[i]..' *❩ _ *❨ ملصق❩ \n' 	ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' ⇠ *❨* '..	video[i]..' *❩ _ *❨ فيديو❩ \n'ii = ii + 1 end
for i=1, #files 	do message = message ..ii..' ⇠ *❨* '..	files[i]..' *❩ _ *❨ ملف❩ \n' ii = ii + 1 end
message = message..'\n𓍦'
if utf8.len(message) > 4096 then
return "⇠ مقدر عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end

----=================================| كود الرد العشوائي المجموعات|===============================================
if MsgText[1]=="اضف رد عشوائي" and msg.GroupActive then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
redis:setex(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return "⇠ تمام, الحين ارسل كلمه الرد للعشوائي"
end


if MsgText[1]== "مسح رد عشوائي" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
redis:setex(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام عيني\n⇠ الحين ارسل الرد العشوائي لمسحه "
end


if MsgText[1] == "مسح الردود العشوائيه" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  " end
local AlRdod = redis:smembers(boss..':KlmatRRandom:'..msg.chat_id_) 
if #AlRdod == 0 then return "⇠ الردود العشوائيه محذوفه بالفعل " end
for k,v in pairs(AlRdod) do redis:del(boss..':ReplayRandom:'..msg.chat_id_..":"..v) redis:del(boss..':caption_replay:Random:'..msg.chat_id_..v) 
end
redis:del(boss..':KlmatRRandom:'..msg.chat_id_) 
return "⇠ اهلا عيني "..msg.TheRankCmd.."  \n⇠ ابشر مسحت جميع الردود العشوائيه "
end

if MsgText[1] == "الردود العشوائيه" then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  " end
message = "⇠ الردود العشـوائيه :\n\n"
local AlRdod = redis:smembers(boss..':KlmatRRandom:'..msg.chat_id_) 
if #AlRdod == 0 then 
message = message .."⇠ لا توجد ردود عشوائيه مضافه !\n"
else
for k,v in pairs(AlRdod) do
local incrr = redis:scard(boss..':ReplayRandom:'..msg.chat_id_..":"..v) 
message = message..k..'- ❨ ['..v..'] ❩ - ❨ *'..incrr..'* ❩ ❨ رد ❩\n'
end
end
return message.."\n"
end
----=================================|نهايه كود الرد العشوائي المجموعات|===============================================

----=================================|كود الرد العشوائي العام|===============================================

if MsgText[1]=="اضف رد عشوائي عام" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
redis:setex(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return "⇠ تمام, الحين ارسل كلمه الرد للعشوائي العام "
end


if MsgText[1]== "مسح رد عشوائي عام" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
redis:setex(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_,300,true)
return "⇠ تمام عيني\n⇠ الحين ارسل الرد العشوائي العام لمسحه"
end

if MsgText[1] == "مسح الردود العشوائيه العامه" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
local AlRdod = redis:smembers(boss..':KlmatRRandom:') 
if #AlRdod == 0 then return "⇠ الردود العشوائيه محذوفه بالفعل " end
for k,v in pairs(AlRdod) do redis:del(boss..":ReplayRandom:"..v) redis:del(boss..':caption_replay:Random:'..v)  end
redis:del(boss..':KlmatRRandom:') 
return "⇠ اهلا عيني "..msg.TheRankCmd.."  \n⇠ ابشر مسحت جميع الردود العشوائيه "
end

if MsgText[1] == "الردود العشوائيه العام" then
if not msg.SudoUser then return "⇠ هذا الامر يخص ( المطور ) بس  \n" end
message = "-التعليقات العشـوائيه العام :\n\n"
local AlRdod = redis:smembers(boss..':KlmatRRandom:') 
if #AlRdod == 0 then 
message = message .."⇠ لا توجد ردود عشوائيه مضافه !\n"
else
for k,v in pairs(AlRdod) do
local incrr = redis:scard(boss..":ReplayRandom:"..v) 
message = message..k..'- ['..v..'] ⋙  ‹ *'..incrr..'* ›  رد\n'
end
end
return message.."\n"
end

----=================================|نهايه كود الرد العشوائي العام|===============================================


if MsgText[1]=="اضف رد" and msg.GroupActive then
if not msg.Director then return "⇠ هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
redis:setex(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_,300,true) 
redis:del(boss..'replay1'..msg.chat_id_..msg.sender_user_id_)
return "⇠ تمام, الحين ارسل كلمه الرد "
end

if MsgText[1] == "ضع اسم للبوت"  then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:setex(boss..'namebot:witting'..msg.sender_user_id_,300,true)
return"⇠ تمام عيني\n⇠ الحين ارسل الاسم  للبوت "
end

if MsgText[1] == 'server' then
if not msg.SudoUser then return "For Sudo Only." end
return io.popen([[

linux_version=`lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '⇠ ‹ Seystem  › \n*↭↭ '"$linux_version"'*' 
echo '*------------------------------\n*⇠ ‹ Memory  › \n*↭↭ '"$memUsedPrc"'*'
echo '*------------------------------\n*⇠ ‹ HardDisk  › \n*↭↭ '"$HardDisk"'*'
echo '*------------------------------\n*⇠ ‹ Processor  › \n*↭↭ '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*⇠ ‹ Location  › \n*↭↭ '`curl http://th3boss.com/ip/location`'*'
echo '*------------------------------\n*⇠ ‹ Server[_]Login  › \n*↭↭ '`whoami`'*'
echo '*------------------------------\n*⇠ ‹ Uptime  ›   \n*↭↭ '"$uptime"'*'
]]):read('*all')
end


if MsgText[1] == 'السيرفر' then
if not msg.SudoUser then return "For Sudo Only." end
return io.popen([[

linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '⇠ ‹ نظام التشغيل  › \n*↭↭ '"$linux_version"'*' 
echo '*------------------------------\n*⇠ ‹ الذاكره العشوائيه  › \n*↭↭ '"$memUsedPrc"'*'
echo '*------------------------------\n*⇠ ‹ وحـده الـتـخـزيـن  › \n*↭↭ '"$HardDisk"'*'
echo '*------------------------------\n*⇠ ‹ الـمــعــالــج  › \n*↭↭ '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*⇠ ‹ موقـع الـسـيـرفـر  › \n*↭↭ '`curl http://th3boss.com/ip/location`'*'
echo '*------------------------------\n*⇠ ‹ الــدخــول  › \n*↭↭ '`whoami`'*'
echo '*------------------------------\n*⇠ ‹ مـده تـشغيـل الـسـيـرفـر  ›   \n*↭↭ '"$uptime"'*'
]]):read('*all')
end



if msg.type == 'channel' and msg.GroupActive then

if msg.SudoBase and (MsgText[1]=="م1" or MsgText[1]=="م2" or MsgText[1]=="م3" or MsgText[1]=="م4" or MsgText[1]=="م6" or MsgText[1]=="الاوامر" or MsgText[1]=="م5") and redis:get(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_)
redis:setex(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_,900,MsgText[1])
sendMsg(msg.chat_id_,msg.id_,"⇠ تماملتعيين كليشة الـ *"..MsgText[1].."* \n⇠ ارسل الكليشه الجديده الحين \n\n⇠ علما تقدر استخدام الاختصارات الاتي : \n \n⇠ {الاسم} : لوضع اسم الحلو\n⇠ {الايدي} : لوضع ايدي الحلو\n⇠ {اليوزر} : لوضع معرف الحلو \n⇠ {الرتبه} : لوضع نوع رتبه الحلو \n⇠ {التفاعل} : لوضع تفاعل الحلو \n⇠ {الرسائل} : لاضهار عدد الرسائل \n⇠ {المجوهرات} : لاضهار عدد النقاط \n⇠ {التكليجات} : لاضهار عدد التكليجات \n⇠ {البوت} : لاضهار اسم البوت\n⇠ {المطور} : لاضهار معرف Dev\n⇠ {تعليق} : لاضهار ردود عشوائيه .\n")
return false
end




if MsgText[1] == "اعدادات المجموعة" or MsgText[1] == "اعدادات المجموعه" then
if not msg.Admin then return "- هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
msg.textmsg = "- اهلا بك في لستة الاوامر  اختر القسم للتحكم بالاوامر ."
msg.KeyboardCmd = keyboardSitting
SendMsgInline(msg)
return false
end

if MsgText[1] == "/Commands@He82Bot" or MsgText[1] == "/Commands" or  MsgText[1] == "الاوامر" then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس  \n" end

SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
text = [[للاستفسار - []]..SUDO_USER..[[]
*⇜ هلا فيك في اوامر البوت *
  ]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
msg.textmsg = [[للاستفسار - []]..SUDO_USER..[[]
*⇜ هلا فيك في اوامر البوت‏‌‌‏‌‌‌‌‏*
]]
msg.KeyboardCmd = keyboardCmd
SendMsgInline(msg)
end,{msg=msg})
return false
end


if MsgText[1]== 'م1' then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
local text = [[  *اوامر الاداره*  
للاستفسار - []]..SUDO_USER..[[]
 *اوامر الرفع والتنزيل*
⇠  مالك اساسي    ( رفع ⟺  تنزيل )
⇠  مالك               ( رفع ⟺  تنزيل )
⇠  مشرف            ( رفع ⟺  تنزيل )
⇠  مدير               ( رفع ⟺  تنزيل )
⇠ ادمن              ( رفع ⟺  تنزيل )
⇠  مميز              ( رفع ⟺  تنزيل )
⇠  تنزيل الكل ⤌ لأزاله جميع الرتب أعلاه

 *اوامر المسح*  

⇠   مسح المالك اساسيين الاساسيين
⇠   مسح المالك اساسيين
⇠  مسح المدراء
⇠   مسح الادمنيه
⇠   مسح المميزين
⇠   مسح المحظورين
⇠   مسح المكتومين
⇠   مسح قائمه المنع
⇠   مسح الردود
⇠   مسح الاوامر
⇠   مسح + عدد
⇠   مسح بالرد
⇠   مسح الايدي
⇠   مسح الترحيب
⇠   مسح الرابط

 *اوامر الطرد الحظر الكتم*  
⇠  حظر 
⇠  طرد  
⇠  كتم 
⇠  تقيد 
⇠ الغاء الحظر 
⇠ الغاء الكتم 
⇠  فك التقييد 
⇠  رفع القيود - لفك ↜ كتم،حظر،تقييد
⇠  منع + الكلمه
⇠ منع بالرد على ملصق او متحركه
⇠ الغاء منع + الكلمه
⇠  طرد البوتات
⇠  طرد المحذوفين
⇠  كشف البوتات]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m1:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end


if MsgText[1]== 
'م2' then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[للاستفسار - []]..SUDO_USER..[[]
 *اوامر الوضع*  
⇠  ضع الترحيب
⇠  ضع القوانين
⇠  ضع وصف
⇠  ضـع رابط
⇠  تغيير امر
⇠  تعيين الايدي

 *اوامر رؤية الاعدادات*  

⇠ المطورين
⇠ المالكين الاساسين
⇠ المالكين 
⇠ المدراء
⇠ الادمنيه
⇠ المميزين
⇠ المحظورين
⇠ القوانين
⇠ المكتومين
⇠ المطور 
⇠  معلوماتي 
⇠ الحمايه  
⇠ الوسائط
⇠ الاعدادت
⇠ المجموعه]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m2:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== 'م3' then
if not msg.Admin then return "- هذا الامر يخص ( الادمن,المدير,المالك,المطور) بس  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[للاستفسار - []]..SUDO_USER..[[]
  *اهلاً بك في قائمة الحماية*

 *اوامر القفل والفتح بالمسح*

⇠ قفل ⤜ ⤛ فتح التعديل  
⇠ قفل ⤜ ⤛ فتح البصمات 
⇠ قفل ⤜ ⤛ فتح الفيديو 
⇠ قفل ⤜ ⤛ فتح الـصــور 
⇠ قفل ⤜ ⤛ فتح الملصقات 
⇠ قفل ⤜ ⤛ فتح الملفات  
⇠ قفل ⤜ ⤛ فتح المتحركه 
⇠ قفل ⤜ ⤛ فتح الدردشه 
⇠ قفل ⤜ ⤛ فتح الروابط 
⇠ قفل ⤜ ⤛ فتح الهاشتاق 
⇠ قفل ⤜ ⤛ فتح البوتات 
⇠ قفل ⤜ ⤛ فتح المعرفات 
⇠ قفل ⤜ ⤛ فتح البوتات بالطرد 
⇠ قفل ⤜ ⤛ فتح الاشعارات 
⇠ قفل ⤜ ⤛ فتح الكلايش 
⇠ قفل ⤜ ⤛ فتح التكرار 
⇠ قفل ⤜ ⤛ فتح التوجيه 
⇠ قفل ⤜ ⤛ فتح الانلاين 
⇠ قفل ⤜ ⤛ فتح الجهات 
⇠ قفل ⤜ ⤛ فتح الــكـــل 
⇠ قفل ⤜ ⤛ فتح السب
⇠ قفل ⤜ ⤛ فتح الفارسيه
⇠ قفل ⤜ ⤛ فتح الانجليزيه
⇠ قفل ⤜ ⤛ فتح الاضافه
⇠ قفل ⤜ ⤛ فتح الصوت
⇠ قفل ⤜ ⤛ فتح الالعاب
⇠ قفل ⤜ ⤛ فتح الماركدوان
⇠ قفل ⤜ ⤛ فتح الويب

 *اوامر الفتح والقفل بالتقييد* 

⇠ قفل ⤜ ⤛ فتح التوجيه بالتقييد 
⇠ قفل ⤜ ⤛ فتح الروابط بالتقييد 
⇠ قفل ⤜ ⤛ فتح المتحركه بالتقييد 
⇠ قفل ⤜ ⤛ فتح الصور بالتقييد 
⇠ قفل ⤜ ⤛ فتح الفيديو بالتقييد 

 *اوامر التفعيل والتعطيل* 

⇠ تفعيل ⤜ ⤛ تعطيل الترحيب 
⇠ تفعيل ⤜ ⤛ تعطيل الردود 
⇠ تفعيل ⤜ ⤛ تعطيل التحذير 
⇠ تفعيل ⤜ ⤛ تعطيل الايدي
⇠ تفعيل ⤜ ⤛ تعطيل الرابط
⇠ تفعيل ⤜ ⤛ تعطيل اطردني
⇠ تفعيل ⤜ ⤛ تعطيل الحظر
⇠ تفعيل ⤜ ⤛ تعطيل الحمايه
⇠ تفعيل ⤜ ⤛ تعطيل المنشن
⇠ تفعيل ⤜ ⤛ تعطيل الايدي بالصوره
⇠ تفعيل ⤜ ⤛ تعطيل التحقق 
⇠ تفعيل ⤜ ⤛ تعطيل التنظيف التلقائي
⇠ تفعيل ⤜ ⤛ الردود العشوائيه
]]


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m3:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== "م المطور" then
if not msg.SudoBase then return " ⇠ هذا الامر يخص ( مطور الاساسي ) بس " end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[ اهلا بك في قائمة اوامر المطورين
للاستفسار - []]..SUDO_USER..[[]

- تفعيل
- تعطيل
- اسم بوتك + غادر
- مسح الادمنيه
- مسح المميزين
- مسح المدراء
- مسح المطورين
- مسح المنشئين
- مسح المالكين الاساسيين
- مسح كلايش التعليمات
- اذاعه
- اذاعه خاص
- اذاعه عام
- اذاعه بالتثبيت
- اذاعه عام بالتوجيه
- تعيين قائمه الاوامر
- مسح كلايش التعليمات
- تعيين كليشه ستارت
- تعيين ايدي عام
- مسح ايدي عام
- تفعيل / تعطيل تعيين الايدي
- تحديث
- تحديث السورس ]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mtwr:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== 'اوامر الرد' then
if not msg.Director then return "- هذا الامر يخص ( المطور,المالك,المدير ) بس  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username


local text = [[ اهلا بك في قائمة اوامر الردود
للاستفسار - []]..SUDO_USER..[[]

-  جميع اوامر الردود 
- الردود : لعرض الردود المثبته
- اضف رد : لاضافه رد جديد
- مسح رد الرد المراد مسحه
- مسح الردود : لمسح كل الردود
- اضف رد عام : لاضافه رد لكل المجموعات
-  مسح رد عام : لمسح الرد العام 
- مسح الردود العامه : لمسح كل ردود العامه ]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mrd:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== "اوامر الملفات" then
if not msg.SudoBase then return"- هذا الامر يخص ( المطور الاساسي) بس  \n" end
local text = [[ اهلا بك في قائمة اوامر الملفات
للاستفسار - []]..SUDO_USER..[[]

- اوامر الملفات

-  `/files`  لعرض قائمه الملفات 
-  `/store`  لعرض متجر الملفات 
-  `sp file.lua`   تثبيت الملف 
-  `dp file.lua` الملف المراد حذفه ]]


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mf:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end


if MsgText[1] == "مغادره" or MsgText[1] == "ادفرني" or MsgText[1] == "احظرني" or MsgText[1] == "اطردني" then
if msg.Admin then return "⇠ لا استطيع طرد المدراء والادمنيه والمالكيين  \n" end
if not redis:get(boss.."lock_leftgroup"..msg.chat_id_) then  return "⇠ امر المغادره معطل من قبل اداره المجموعة  \n" end
kick_user(msg.sender_user_id_,msg.chat_id_,function(arg,data)
if data.ID == "Ok" then
StatusLeft(msg.chat_id_,msg.sender_user_id_)
send_msg(msg.sender_user_id_,"⇠ اهلا عيني , لقد تم طردك من المجموعه بامر منك \n⇠ اذا كان هذا بالخطا او اردت الرجوع للمجموعه \n\n-فهذا رابط المجموعه \n-"..Flter_Markdown(redis:get(boss..'group:name'..msg.chat_id_)).." :\n\n["..redis:get(boss..'linkGroup'..msg.chat_id_).."]\n")
sendMsg(msg.chat_id_,msg.id_,"- لقد تم طردك  , ارسلت لك رابط المجموعه في الخاص اذا وصلت لك تستطيع الرجوع متى شئت ")
else
sendMsg(msg.chat_id_,msg.id_,"⇠ لا استطيع طردك لانك مشرف في المجموعه  ")
end
end)
return false
end

end 

if MsgText[1] == "التسليه" or MsgText[1]=="التسليه" then
return [[
*اهلين عيني في اوامر الاغاني*
————————————————————
*لتحميل من اليوتيوب*

بحث + اسم اغنية

*لتحميل من ساوند*

ساوند + اسم اغنية ]]

end

if MsgText[1] == 'الاوامر خاص' then
sendMsg(msg.chat_id_,msg.id_,'اهلا عزيزي تم ارسال الاوامر لك في الخاص',msg.message_id,'md')
sendMsg(msg.chat_id_,msg.id_,txt,0, 'md',awamer_Klesha_m(msg.chat_id_,msg.id_,1))
end



if MsgText[1] == "الساعه" then
return "\n⇠ الـسـاعه الحين : "..os.date("%I:%M%p").."\n"
.."⇠ الـتـاريـخ : "..os.date("%Y/%m/%d")
end

if MsgText[1] == "التاريخ" then
return "\n⇠ الـتـاريـخ : "..os.date("%Y/%m/%d")
end

if MsgText[1] == "تفعيل الاشتراك الاجباري" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
if redis:get(boss..":UserNameChaneel") then
return "⇠ اهلا عزيزي المطور \n⇠ الاشتراك من قبل مفعل"
else
redis:setex(boss..":ForceSub:"..msg.sender_user_id_,350,true)
return "- مرحبا بـك في نظام الاشتراك الاجباري\n⇠ الحين ارسل معرف قـنـاتـك"
end
end

if MsgText[1] == "تعطيل الاشتراك الاجباري" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
local SubDel = redis:del(boss..":UserNameChaneel")
if SubDel == 1 then
return "⇠ تم تعطيل الاشتراك الاجباري . "
else
return "⇠ الاشتراك الاجباري بالفعل معطل . "
end
end

if MsgText[1] == "الاشتراك الاجباري" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
local UserChaneel = redis:get(boss..":UserNameChaneel")
if UserChaneel then
return "⇠ اهلا عزيزي المطور \n⇠ الاشتراك الاجباري للقناة : ["..UserChaneel.."] "
else
return "⇠ مافيه قناة مفعله ع الاشتراك الاجباري. "
end
end

if MsgText[1] == "تغيير الاشتراك الاجباري" then
if not msg.SudoBase then return"⇠ هذا الامر يخص ( مطور الاساسي ) بس  \n" end
redis:setex(boss..":ForceSub:"..msg.sender_user_id_,350,true)
return "- مرحبا بـك في نظام الاشتراك الاجباري\n⇠ الحين ارسل معرف قـنـاتـك"
end





end



local function dBoss(msg)

if msg.type == "pv" then 

if not msg.SudoUser then
local msg_pv = tonumber(redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
if msg_pv > 5 then
redis:setex(boss..':mute_pv:'..msg.sender_user_id_,18000,true)   
return sendMsg(msg.chat_id_,0,'⇠ تم حظرك من البوت بسبب التكرار ') 
end
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',2,msg_pv+1)
end

if msg.text=="/start" then

if msg.SudoBase then
local text = '⇠ اهلينن عينيي YxY\n⇠ انت‌‏ المـطـور الاساسي هنا  \n...\n⇠ تقدر تتحكم بكل الاوامر الموجودة بالكيبورد\n⇠ بس اضغط على الامر اللي تبيه ‌‏ '

local keyboard = {
{"الاحصائيات"},
{"ضع اسم للبوت","ضع صوره للترحيب"},
{"تعطيل التواصل","تفعيل التواصل"},
{"تعطيل تعيين الايدي","تفعيل تعيين الايدي"},

{"تعطيل البوت خدمي","تفعيل البوت خدمي"},
{"مسح كليشه الستارت","تعيين كليشه الستارت"},
{"مسح كليشه الايدي عام","تعيين كليشه الايدي عام"},

{"اذاعه بالتثبيت","تعطيل الاذاعه","تفعيل الاذاعه"},
{"اذاعه","اذاعه عام","اذاعه خاص"},
{"الملفات","اذاعه عام بالتوجيه"},
{"المحظورين من التواصل","نقل ملكيه البوت"},
{"تحديث","قائمه العام","قناة السورس"},
{"المطورين","ايدي"},
{"اضف رد عام","الردود العامه"},
{"تحديث السورس"},
{"الغاء الامر"}}
return send_key(msg.sender_user_id_,text,keyboard,nil,msg.id_)
else
redis:sadd(boss..'users',msg.sender_user_id_)
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = ""
else
SUDO_USERR = ""
end


text = [[ اهلين انا  []]..redis:get(boss..':NameBot:')..[[] 🧚🏻‍♀️
↞ آختصاصي اداره‏‏ المجموعات 
↞ مـن السـبام والتوجيه‏‏ والتكرار والخ...
↞ كت تويت, يوتيوب
↞ عشان تفعلني ارفعني اشراف وارسل تفعيل. البوت
]]..SUDO_USERR..[[

]]
GetUserID(msg.sender_user_id_,function(arg,data)
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
text = redis:get(boss..':Text_Start') or text
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local Emsgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "مافيه" end  
text = text:gsub("{الاسم}",Name)
text = text:gsub("{الايدي}",msg.sender_user_id_)
text = text:gsub("{اليوزر}",UserNameID)
text = text:gsub("{الرتبه}",msg.TheRank)
text = text:gsub("{البوت}",redis:get(boss..':NameBot:'))
text = text:gsub("{المطور}",SUDO_USER)
text = text:gsub("{تعليق}",RandomText())

xsudouser = SUDO_USER:gsub('@','')
xsudouser = xsudouser:gsub([[\_]],'_')
local inline = {{{text="للاستفسارات  ",url="t.me/"..xsudouser}}}
send_key(msg.sender_user_id_,Flter_Markdown(text),nil,inline,msg.id_)
end,nil)
return false
end
end

if msg.SudoBase then
if msg.text then 
if msg.text == "المحظورين" or msg.text == "المحظورين من التواصل" then 
return sendMsg(msg.chat_id_,0,GetListBannedpv(msg) )  
end
if msg.text == "مسح المحظورين" then 
redis:del(boss..'bannedpv')
return sendMsg(msg.chat_id_,0,'⇠ تم مسحت كل المحظورين ') 
end


if msg.text:match('^حظر @[%a%d_]+') and not msg.reply_id then 
local utext = msg.text:gsub("حظر ","")
GetUserName(utext,function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
elseif UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ هييه مايمديك تحظر مطور السورس ") 
end

redis:hset(boss..'username:'..UserID,'username',arg.UserName)
if redis:sismember(boss..'bannedpv',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 ["..arg.UserName.."] 」 \n⇠ تم بالتاكيد حظره  من التواصل") 
end
redis:sadd(boss..'bannedpv',UserID)
sendMsg(UserID,arg.MsgID,"⇠ تم حظرك من التواصل") 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 ["..arg.UserName.."] 」 \n⇠ تم حظرته  من التواصل") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=utext})
return false
end
--============================================================
if msg.text:match('^حظر %d+$') and not msg.reply_id then 
local itext = msg.text:gsub("حظر ","")
GetUserID(itext,function(arg,data)
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if not data.id_ then return sendMsg(ChatID,MsgID,"⇠ الحلو مافيه ") end
local UserID = data.id_
local Resolv = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if UserID == 1419573259 or UserID == 1419573259 then 
return sendMsg(ChatID,MsgID,"⇠ هييه مايمديك تحظر مطور السورس ") 
end
if redis:sismember(boss..'bannedpv',UserID) then 
return sendMsg(ChatID,MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم بالتاكيد حظره  من التواصل ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'bannedpv',UserID)
sendMsg(UserID,MsgID,"⇠ تم حظرك من التواصل") 
return sendMsg(ChatID,MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم حظرته  من التواصل ") 
end,{msg=msg}) 
return false
end 
--============================================================
--============================================================

if msg.text:match('^الغاء الحظر @[%a%d_]+') and not msg.reply_id then 
local utext = msg.text:gsub("الغاء الحظر ","")
print(utext)
GetUserName(utext,function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضـو به‌‏ذا المـعرف - ") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
if not redis:sismember(boss..'bannedpv',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 ["..arg.UserName.."] 」 \n⇠ تم بالتاكيد الغاء الحظر  من التواصل") 
end
redis:srem(boss..'bannedpv',UserID)
sendMsg(UserID,arg.MsgID,"⇠ تم الغاء حظرك من التواصل") 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ الحلو「 ["..arg.UserName.."] 」 \n⇠ تم الغاء الحظر  من التواصل") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=utext})
return false
end
--============================================================
if msg.text:match('^الغاء الحظر %d+$') and not msg.reply_id then 
local itext = msg.text:gsub("الغاء الحظر ","")
GetUserID(itext,function(arg,data)
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if not data.id_ then return sendMsg(ChatID,MsgID,"⇠ الحلو مافيه") end
local UserID = data.id_
local Resolv = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'bannedpv',UserID) then 
return sendMsg(ChatID,MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم بالتاكيد الغاء الحظر  من التواصل ") 
end
redis:srem(boss..'bannedpv',UserID)
sendMsg(UserID,MsgID,"⇠ تم الغاء حظرك من التواصل") 
return sendMsg(ChatID,MsgID,"⇠ الحلو「 "..NameUser.." 」 \n⇠ تم الغاء الحظر  من التواصل ") 
end,{msg=msg}) 
return false
end 
end 
--============================================================
--============================================================


if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.forward_info_ then return false end
local FwdUser = data.forward_info_.sender_user_id_
local MSG_ID = (redis:get(boss.."USER_MSG_TWASEL"..data.forward_info_.date_) or 1)
msg = arg.msg
local SendOk = false
if data.content_.ID == "MessageDocument" then return false end
if msg.text then
if msg.text  == "حظر" then
GetUserID(FwdUser,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data,20) end
if FwdUser == 1419573259 or FwdUser == 1419573259 then 
return sendMsg(arg.ChatID,arg.id_,"⇠ هييه مايمديك تحظر مطور الاساسي ") 
end
redis:hset(boss..'username:'..arg.FwdUser,'username',USERNAME)
if redis:sismember(boss..'bannedpv',FwdUser) then 
return sendMsg(arg.ChatID,arg.id_,"⇠ الحلو「 ["..USERNAME.."] 」 \n⇠ تم بالتاكيد حظره  من التواصل") 
end
redis:sadd(boss..'bannedpv',arg.FwdUser)
sendMsg(arg.FwdUser,arg.id_,"⇠ تم حظرك من التواصل") 
return SendMention(arg.sender_user_id_,data.id_,arg.id_,"⇠ تم حظر الحلو \n⇠ معرفه : "..USERNAME.." ",39,utf8.len(USERNAME)) 
end,{sender_user_id_=msg.sender_user_id_,ChatID=msg.chat_id_,FwdUser=FwdUser,id_=msg.id_})
return false
elseif msg.text == "الغاء الحظر" then
GetUserID(FwdUser,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data,20) end
if not redis:sismember(boss..'bannedpv',arg.sender_user_id_) then 
return sendMsg(arg.ChatID,arg.id_,"⇠ الحلو「 ["..USERNAME.."] 」 \n⇠ تم بالتاكيد الغاء حظره  من التواصل") 
end
redis:srem(boss..'bannedpv',arg.sender_user_id_)
sendMsg(arg.sender_user_id_,arg.id_,"⇠ تم الغاء حظرك من التواصل") 
return SendMention(arg.ChatID,data.id_,arg.id_,"⇠ تم الغاء حظر الحلو \n⇠ معرفه : "..USERNAME.." 🏌🏻",38,utf8.len(USERNAME)) 
end,{ChatID=msg.chat_id_,sender_user_id_=FwdUser,id_=msg.id_})
return false
end
sendMsg(FwdUser,MSG_ID,Flter_Markdown(msg.text))
SendOk = true
elseif msg.content_.ID == "MessageSticker" then
sendSticker(FwdUser,MSG_ID,msg.content_.sticker_.sticker_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
sendPhoto(FwdUser,MSG_ID,photo_id,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageVoice" then
sendVoice(FwdUser,MSG_ID,msg.content_.voice_.voice_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageAnimation" then
sendAnimation(FwdUser,MSG_ID,msg.content_.animation_.animation_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageVideo" then
sendVideo(FwdUser,MSG_ID,msg.content_.video_.video_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageAudio" then
sendAudio(FwdUser,MSG_ID,msg.content_.audio_.audio_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
end
if SendOk then
GetUserID(FwdUser,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data,20) end
SendMention(arg.sender_user_id_,data.id_,arg.id_,"⇠ تم ارسـال الرسـال‏‏ه \n⇠ الى : "..USERNAME.." ",39,utf8.len(USERNAME)) 
end,{sender_user_id_=msg.sender_user_id_,id_=msg.id_})
end
end,{msg=msg})
end
else
if redis:sismember(boss..'bannedpv',msg.sender_user_id_) then  return false end

if not redis:get(boss..'lock_twasel') then
if msg.forward_info_ or msg.content_.ID == "MessageSticker" or msg.content_.ID == "MessageUnsupported" or msg.content_.ID == "MessageDocument" then
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش لا يمـكنك ارسـال {ملف , توجيه‌‏ , مـلصـق , فديو كام} ❗️")
end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "\n🏌 "..SUDO_USER
else
SUDO_USERR = ""
end
redis:setex(boss.."USER_MSG_TWASEL"..msg.date_,43200,msg.id_)
sendMsg(msg.chat_id_,msg.id_,"تم ارسال رسالتك للمطور ")
fwdMsg(SUDO_ID,msg.chat_id_,msg.id_)
return false
end
end
end

function CaptionInsert(msg,input,public)
if msg.content_ and msg.content_.caption_ then 
if public then
redis:hset(boss..':caption_replay:Random:'..msg.klma,input,msg.content_.caption_) 
else
redis:hset(boss..':caption_replay:Random:'..msg.chat_id_..msg.klma,input,msg.content_.caption_) 
end
end
end

--====================== Reply Random Public =====================================
if redis:get(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_) then
klma = redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
msg.klma = klma
if msg.text == "تم" then
redis:del(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه رد متعدد عشوائي  \n\n⇠ تقدر ترسل (['..klma..']) لاضهار الردود العشوائيه . ')
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return false
end

local CountRdod = redis:scard(boss..':ReplayRandom:'..klma) or 1
local CountRdod2 = 10 - tonumber(CountRdod)
local CountRdod = 9 - tonumber(CountRdod)
if CountRdod2 == 0 then 
redis:del(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'- وصلت الحد الاقصى لعدد الردود \n⇠ تم اضافه الرد (['..klma..']) للردود العشوائيه .')
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return false
end
if msg.text then 
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر ")
end
CaptionInsert(msg,msg.text,true)
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Text:"..msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'تم حطيت الرد باقي '..CountRdod..'\n تم ادراج الرد ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Photo:"..photo_id) 
CaptionInsert(msg,photo_id,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج صور للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVoice" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Voice:"..msg.content_.voice_.voice_.persistent_id_) 
CaptionInsert(msg,msg.content_.voice_.voice_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الفويس للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessageAnimation" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Animation:"..msg.content_.animation_.animation_.persistent_id_) 
CaptionInsert(msg,msg.content_.animation_.animation_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج المتحركه للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVideo" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Video:"..msg.content_.video_.video_.persistent_id_) 
CaptionInsert(msg,msg.content_.video_.video_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الفيديو للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageAudio" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Audio:"..msg.content_.audio_.audio_.persistent_id_) 
CaptionInsert(msg,msg.content_.audio_.audio_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الصوت للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageDocument" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Document:"..msg.content_.document_.document_.persistent_id_) 
CaptionInsert(msg,msg.content_.document_.document_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الملف للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')  
elseif msg.content_.ID == "MessageSticker" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Sticker:"..msg.content_.sticker_.sticker_.persistent_id_) 
CaptionInsert(msg,msg.content_.sticker_.sticker_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الملصق للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
end  

end
--====================== End Reply Random Public =====================================
--====================== Reply Random Only Group =====================================
if redis:get(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_) then
klma = redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
msg.klma = klma
if msg.text == "تم" then
redis:del(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه رد متعدد عشوائي \n⇠ تقدر ترسل (['..klma..']) لاضهار الردود العشوائيه . ')
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return false
end

local CountRdod = redis:scard(boss..':ReplayRandom:'..msg.chat_id_..":"..klma) or 1
local CountRdod2 = 10 - tonumber(CountRdod)
local CountRdod = 9 - tonumber(CountRdod)
if CountRdod2 == 0 then 
redis:del(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'- وصلت الحد الاقصى لعدد الردود \n⇠ تم اضافه الرد (['..klma..']) للردود العشوائيه .')
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return false
end
if msg.text then 
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n")
end
CaptionInsert(msg,msg.text,false)
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Text:"..msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'تم حطيت الرد باقي '..CountRdod..'\n تم ادراج الرد ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Photo:"..photo_id) 
CaptionInsert(msg,photo_id,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج صور للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVoice" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Voice:"..msg.content_.voice_.voice_.persistent_id_) 
CaptionInsert(msg,msg.content_.voice_.voice_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الفويس للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessageAnimation" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Animation:"..msg.content_.animation_.animation_.persistent_id_) 
CaptionInsert(msg,msg.content_.animation_.animation_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج المتحركه للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVideo" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Video:"..msg.content_.video_.video_.persistent_id_) 
CaptionInsert(msg,msg.content_.video_.video_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الفيديو للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageAudio" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Audio:"..msg.content_.audio_.audio_.persistent_id_) 
CaptionInsert(msg,msg.content_.audio_.audio_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الصوت للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageDocument" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Document:"..msg.content_.document_.document_.persistent_id_) 
CaptionInsert(msg,msg.content_.document_.document_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الملف للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')  
elseif msg.content_.ID == "MessageSticker" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Sticker:"..msg.content_.sticker_.sticker_.persistent_id_) 
CaptionInsert(msg,msg.content_.sticker_.sticker_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم ادراج الملصق للرد باقي '..CountRdod..' \n⇠ ارسل رد اخر او ارسل {تم} .')
end  

end
--====================== End Reply Random Only Group =====================================


--====================== Reply Only Group =====================================
if redis:get(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_)
if msg.content_ and msg.content_.caption_ then redis:hset(boss..':caption_replay:'..msg.chat_id_,klma,msg.content_.caption_) end
if msg.text then 
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر ")
end
redis:hset(boss..'replay:'..msg.chat_id_,klma,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\nتم اضافة الرد \n')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:hset(boss..'replay_photo:group:'..msg.chat_id_,klma,photo_id)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه صوره للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageVoice" then
redis:hset(boss..'replay_voice:group:'..msg.chat_id_,klma,msg.content_.voice_.voice_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضفت الفويس للرد  \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageAnimation" then
redis:hset(boss..'replay_animation:group:'..msg.chat_id_,klma,msg.content_.animation_.animation_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه متحركه للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageVideo" then
redis:hset(boss..'replay_video:group:'..msg.chat_id_,klma,msg.content_.video_.video_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه فيديو للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
elseif msg.content_.ID == "MessageAudio" then
redis:hset(boss..'replay_audio:group:'..msg.chat_id_,klma,msg.content_.audio_.audio_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه للصوت للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
elseif msg.content_.ID == "MessageDocument" then
redis:hset(boss..'replay_files:group:'..msg.chat_id_,klma,msg.content_.document_.document_.persistent_id_ )
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه ملف للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')  
elseif msg.content_.ID == "MessageSticker" then
redis:hset(boss..'replay_sticker:group:'..msg.chat_id_,klma,msg.content_.sticker_.sticker_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه ملصق للرد \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
end  

end

--====================== Reply All Groups =====================================
if redis:get(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
if msg.content_.caption_ then redis:hset(boss..':caption_replay:',klma,msg.content_.caption_) end
if msg.text then
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر ")
end
redis:hset(boss..'replay:all',klma,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\nتم اضافة الرد \n لكل المجموعات ')
elseif msg.content_.ID == "MessagePhoto" then 
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:hset(boss..'replay_photo:group:',klma,photo_id)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه صوره للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageVoice" then
redis:hset(boss..'replay_voice:group:',klma,msg.content_.voice_.voice_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضفت الفويس للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageAnimation" then
redis:hset(boss..'replay_animation:group:',klma,msg.content_.animation_.animation_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه متحركه للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو \n𓍦')
elseif msg.content_.ID == "MessageVideo" then
redis:hset(boss..'replay_video:group:',klma,msg.content_.video_.video_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه فيديو للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
elseif msg.content_.ID == "MessageAudio" then
redis:hset(boss..'replay_audio:group:',klma,msg.content_.audio_.audio_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه للصوت للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
elseif msg.content_.ID == "MessageDocument" then
redis:hset(boss..'replay_files:group:',klma,msg.content_.document_.document_.persistent_id_ )
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه ملف للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')  
elseif msg.content_.ID == "MessageSticker" then
redis:hset(boss..'replay_sticker:group:',klma,msg.content_.sticker_.sticker_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه ملصق للرد العام \n⇠ تقدر ترسل (['..klma..']) عشان تشوف الرد ياحلو')
end  

end

if msg.text then
--====================== Requst UserName Of Channel For ForceSub ==============

if msg.Director and (msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Oo][Rr][Gg]")) and redis:get(boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..'linkGroup'..msg.chat_id_,msg.text)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تعيين الرابط   ")
return false
end

if msg.Creator and redis:get(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..":infoiduser_public:"..msg.chat_id_,msg.text)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تعيين الايدي  \n⇠ تقدر تجربة الامر الحين ")
return false
end

if msg.SuperCreator and redis:get(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_) then 

NameUser = redis:get(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
UserID = redis:get(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
if not msg.text:match("[1234567]") and not msg.text:match("[*]") and not msg.text:match("[*][*]") then
redis:del(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم الغاء الامر , يجب ان يحتوي رسالتك ع ارقام الصلاحيات المعروضه . ")   
end

Nikname = msg.text:gsub("[1234567]","")
Nikname = Nikname:gsub("[*]","")
ResAdmin = UploadAdmin(msg.chat_id_,UserID,msg.text)  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: not enough rights"}' then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش البوت ليس لديه صلاحيه رفع مشرفين في المجموعه ") 
elseif ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: can\'t remove chat owner"}' then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش مقدر التحكم بصلاحيات المالك للمجموعه. ") 
elseif ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش مقدر التحكم بصلاحيات المشرف مرفوع من قبل مالك اخر . ") 
elseif ResAdmin == '{"ok":true,"result":true}' then
ChangeNikname(msg.chat_id_,UserID,Nikname)
redis:sadd(boss..'admins:'..msg.chat_id_,UserID)
local trues = ""
local falses = "✖️"

infochange = falses
infochange1 = falses
infochange2 = falses
infochange3 = falses
infochange4 = falses
infochange5 = falses
if msg.text:match(1) then
infochange = trues
end
if msg.text:match(2) then
infochange1 = trues
end
if msg.text:match(3) then
infochange2 = trues
end
if msg.text:match(4) then
infochange3 = trues
end
if msg.text:match(5) then
infochange4 = trues
end
if msg.text:match(6) then
infochange5 = trues
end
if msg.text:match("[*][*]") then
infochange = trues
infochange1 = trues
infochange2 = trues
infochange3 = trues
infochange4 = trues
infochange5 = trues
elseif msg.text:match("[*]") then
infochange = trues
infochange1 = trues
infochange2 = trues
infochange3 = trues
infochange4 = trues
end

if Nikname == "" then Nikname = "بدون" end
sendMsg(msg.chat_id_,msg.id_,"⇠ المشرف  ⋙ 「 "..NameUser.." 」 صلاحياته : \n\n"
.."⇠ تغيير معلومات المجموعه : "..infochange.."\n"
.."⇠ صلاحيه حذف الرسائل : "..infochange1.."\n"
.."⇠ صلاحيه دعوه مستخدمين : "..infochange2.."\n"
.."⇠ صلاحيه حظر وتقيدالحلوين : "..infochange3.."\n"
.."⇠ صلاحيه تثبيت الرسائل : "..infochange4.."\n"
.."⇠ صلاحيه رفع مشرفين اخرين : "..infochange5.."\n\n"
.."⇠ القـب : ["..Nikname.."]\n"
.."") 
else
sendMsg(msg.chat_id_,msg.id_,"⇠ المشرف  ⋙ 「 "..NameUser.." 」  حدث خطا ما ") 
end
redis:del(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.Creator and redis:get(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_) and not redis:get(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_) then 
if msg.text=="م1" or msg.text=="م2" or msg.text=="م3" or msg.text=="م4" or msg.text=="م6" or msg.text=="الاوامر" or msg.text=="م5" then return false end
local amr = redis:get(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_)
if amr == "م1" then
redis:set(boss..":awamer_Klesha_m1:",msg.text)
elseif amr == "م2" then
redis:set(boss..":awamer_Klesha_m2:",msg.text)
elseif amr == "م3" then
redis:set(boss..":awamer_Klesha_m3:",msg.text)
elseif amr == "م4" then
redis:set(boss..":awamer_Klesha_mtwr:",msg.text)
elseif amr == "م6" then
redis:set(boss..":awamer_Klesha_mrd:",msg.text)
elseif amr == "م5" then
redis:set(boss..":awamer_Klesha_mf:",msg.text)
elseif amr == "الاوامر" then
redis:set(boss..":awamer_Klesha_m:",msg.text)
end
redis:del(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم تعيين كليشة التعليمات  \n⇠ تقدر تجربة الامر *{"..amr.."}* ")
end


if msg.SudoUser and redis:get(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..":infoiduser",msg.text)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تعيين الايدي  \n⇠ تقدر تجربة الامر الحين ")
return false
end

--==========================================================================================================

if msg.Director and redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_) then
local Awammer 	= redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
Amr = redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_)
checknewamr = false

for name,Course in pairs(Awammer) do
if name == msg.text then 
checknewamr = true 
end 
end
if checknewamr  then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش لايمكن اضافه امر مكرر في القائمه")
else
for k, Boss in pairs(XBoss) do 
local cceck,sec = Boss:gsub("[(]"..Amr.."[)]","("..msg.text..")")
print(cceck,sec)
if sec ~= 0 then
redis:hset(boss..":AwamerBotArray:"..msg.chat_id_,cceck,Boss)
redis:hset(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text,Amr)
end
end  
redis:hset(boss..":AwamerBot:"..msg.chat_id_,msg.text,Amr)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تغيير الامر القديم ["..Amr.."] \n⇠ الى الامر الجديد ["..msg.text.."] ")
end
redis:del(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_)
return false
end

if msg.Director and not redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_) then
local Awammer 	= redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
local Amr = redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)

local checknewamr = false

for name,Course in pairs(Awammer) do if name == msg.text then checknewamr = true end end 
if checknewamr  then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش لايمكن اضافه امر مكرر في القائمه ")
else
for k, Boss in pairs(XBoss) do 
local cceck,sec = Boss:gsub("[(]"..Amr.."[)]","("..msg.text..")")
if sec ~= 0 then
redis:hset(boss..":AwamerBotArray:"..msg.chat_id_,cceck,Boss) 
redis:hset(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text,Amr)
end
end 
redis:hset(boss..":AwamerBot:"..msg.chat_id_,msg.text,Amr)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تغيير الامر القديم ["..Amr.."] \n⇠ الى الامر الجديد ["..msg.text.."] ")
end
redis:del(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)
return false
end

if msg.Director and redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) then
local checkAmr = false
for k, Boss in pairs(XBoss) do if msg.text:match(Boss) then checkAmr = true end end      
if checkAmr then
sendMsg(msg.chat_id_,msg.id_,"⇠ تمام عزيزي , لتغير امر {* "..msg.text.." *} \n꒐ ارسل الامر الجديد الان ")
redis:setex(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_,900,msg.text)
else
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش مافيه هذا الامر في البوت لتتمكن من تغييره  \n")
end
redis:del(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.SudoUser and msg.text and redis:get(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_)

if msg.text ~= "مطور الاساسي" and msg.text ~= "مطور" and msg.text ~= "مالك" and msg.text ~= "منشئ" and msg.text ~= "مدير" and msg.text ~= "ادمن" and msg.text ~= "مميز" then
sendMsg(msg.chat_id_,msg.id_,"معليش هذه الرتبه غير متوفره في السورس \n⇠ تم الغاء الامر")
return false
end

if msg.text == "مطور الاساسي" then
redis:del(boss..":RtbaNew1:"..msg.chat_id_)
elseif msg.text == "مطور" then
redis:del(boss..":RtbaNew2:"..msg.chat_id_)
elseif msg.text == "مالك اساسي" then
redis:del(boss..":RtbaNew8:"..msg.chat_id_)
elseif msg.text == "مالك" then
redis:del(boss..":RtbaNew3:"..msg.chat_id_)
elseif msg.text == "منشئ" then
redis:del(boss..":RtbaNew4:"..msg.chat_id_)
elseif msg.text == "مدير" then
redis:del(boss..":RtbaNew5:"..msg.chat_id_)
elseif msg.text == "ادمن" then
redis:del(boss..":RtbaNew6:"..msg.chat_id_)
elseif msg.text == "مميز" then
redis:del(boss..":RtbaNew7:"..msg.chat_id_)
end

sendMsg(msg.chat_id_,msg.id_,"⇠ تم حذفت الرتبه المضافه")
return false
end

if msg.SudoUser and msg.text and redis:get(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_)

if msg.text ~= "مطور الاساسي" and msg.text ~= "مالك اساسي"  and msg.text ~= "مطور" and msg.text ~= "مالك" and msg.text ~= "منشئ" and msg.text ~= "مدير" and msg.text ~= "ادمن" and msg.text ~= "مميز" then
sendMsg(msg.chat_id_,msg.id_,"معليش هذه الرتبه غير متوفره في السورس \n⇠ تم الغاء الامر")
return false
end

redis:setex(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_,1000,msg.text)
sendMsg(msg.chat_id_,msg.id_,"⇠ الحين ارسل الرتبه الجديده")
return false
end


if msg.SudoUser and msg.text and redis:get(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_) then 


local rtbanamenew = redis:get(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
if rtbanamenew == "مطور الاساسي" then
redis:set(boss..":RtbaNew1:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مطور" then
redis:set(boss..":RtbaNew2:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مالك اساسي" then
redis:set(boss..":RtbaNew8:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مالك" then
redis:set(boss..":RtbaNew3:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "منشئ" then
redis:set(boss..":RtbaNew4:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مدير" then
redis:set(boss..":RtbaNew5:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "ادمن" then
redis:set(boss..":RtbaNew6:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مميز" then
redis:set(boss..":RtbaNew7:"..msg.chat_id_,msg.text)
end

redis:del(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تغيير الرتبه   \n\n•  ["..rtbanamenew.."] ↭ ["..msg.text.."]\n")
return false
end


if msg.Director and redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) then
local checkk = redis:hdel(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text)

local AmrOld = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
amrnew = ""
amrold = ""
amruser = msg.text.." @user"
amrid = msg.text.." 23434"
amrklma = msg.text.." ffffff"
amrfile = msg.text.." fff.lua"
for Amor,ik in pairs(AmrOld) do
if msg.text:match(Amor) then			
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amruser:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrid:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrklma:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrfile:match(Amor) then
print("꒐AMrnew : "..Amor,"꒐AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
end
end

if checkk ~=0 then
tiires =  "⇠ تم مسحت الامر {* "..msg.text.." *} من قائمه الاومر "
else
tiires = "⇠ هذا الامر مو موجود اصلا "
end
sendMsg(msg.chat_id_,msg.id_,tiires)
redis:del(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_)
return false
end

--==========================================================================================================

if msg.Director and redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) then

local checkk = redis:hdel(boss..":AwamerBot:"..msg.chat_id_,msg.text)
if checkk ~=0 then
tiires =  "⇠ تم مسحت الامر {* "..msg.text.." *} من قائمه الاومر "
else
tiires = "⇠ هذا الامر مو موجود اصلا "
end
sendMsg(msg.chat_id_,msg.id_,tiires)
redis:del(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.SudoBase and redis:get(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_) then
if msg.text:match("^@[%a%d_]+$") then
GetUserName(msg.text,function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو بذا اليوزر!") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"⇠ مقدر رفع حساب بوت") end 
local UserID = data.id_
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش مقدر ارفع البوت") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"⇠ مافيه عضو باليوزر ذا!") 
end
if CheckUserinstall(arg.USERNAME) then return sendMsg(arg.ChatID,arg.MsgID,"⇠ معليش هذا الحساب محظور من سيرفرات حماية YxY ") end
redis:set(boss..":SUDO_ID:",UserID)
local usero = arg.USERNAME:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID,'username',usero)
sendMsg(msg.chat_id_,msg.id_,"⇠ تمت العملية  وتم تحويل ملكية البوت \n⇠ الى الحساب الاتي : ["..arg.USERNAME:gsub([[\_]],"_").."]")
dofile("./inc/Run.lua")
print("Update Source And Reload ~ ./inc/Run.lua And change username sudo")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,USERNAME=msg.text})

else
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش , هناك خطا عندك \n⇠ هذا ليس معرف مستخدم ولا يحتوي على @  .")
end
redis:del(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_)
return false 
end


if redis:get(boss..":ForceSub:"..msg.sender_user_id_) then
redis:del(boss..":ForceSub:"..msg.sender_user_id_)
if msg.text:match("^@[%a%d_]+$") then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..msg.text..'&user_id='..msg.sender_user_id_)
if res == 400 then
local Req = JSON.decode(url)
if Req.description == "Bad Request: chat not found" then 
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش , هناك خطا عندك \n⇠ المعرف الذي ارسلته ليس معرف قناة.")
return false
elseif Req.description == "Bad Request: user not found" then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش , لقد نسيت شيئا \n⇠ يجب رفع البوت مشرف في قناتك لتتمكن من تفعيل الاشتراك الاجباري .")
elseif Req.description == "Bad Request: CHAT_ADMIN_REQUIRED" then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش , لقد نسيت شيئا \n⇠ يجب رفع البوت مشرف في قناتك لتتمكن من تفعيل الاشتراك الاجباري .")
return false
end
else
redis:set(boss..":UserNameChaneel",msg.text)
sendMsg(msg.chat_id_,msg.id_,"- جـيـد , الحين لقد تم تفعيل الاشتراك الاجباري\n⇠ على قناتك : ["..msg.text.."]")
return false
end
else
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش , عزيزي المطور \n⇠ هذا ليس معرف قناة , حاول مجددا .")
return false
end
end

if redis:get(boss..'namebot:witting'..msg.sender_user_id_) then --- استقبال اسم البوت 
redis:del(boss..'namebot:witting'..msg.sender_user_id_)
redis:set(boss..':NameBot:',msg.text)
Start_Bot() 
sendMsg(msg.chat_id_,msg.id_,"⇠ تم تغير اسم البوت \n⇠ الحين اسمه "..Flter_Markdown(msg.text).." ")
return false
end

if redis:get(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد لكل المجموعات
if not redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال كلمه الرد لكل المجموعات
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه كلمه الرد باكثر من 25 حرف \n")
end
redis:hdel(boss..'replay_photo:group:',msg.text)
redis:hdel(boss..'replay_voice:group:',msg.text)
redis:hdel(boss..'replay_animation:group:',msg.text)
redis:hdel(boss..'replay_audio:group:',msg.text)
redis:hdel(boss..'replay_sticker:group:',msg.text)
redis:hdel(boss..'replay_video:group:',msg.text)
redis:hdel(boss..'replay_files:group:',msg.text)
redis:setex(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"- جيد , الحين ارسل جوا ب الردالعام \n⇠ [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] \n\n\n⇠ علما ان الاختصارات كالاتي : \n \n⇠ {الاسم} : لوضع اسم الحلو\n⇠ {الايدي} : لوضع ايدي الحلو\n⇠ {اليوزر} : لوضع معرف الحلو \n⇠ {الرتبه} : لوضع نوع رتبه الحلو \n⇠ {التفاعل} : لوضع تفاعل الحلو \n⇠ {الرسائل} : لاضهار عدد الرسائل \n⇠ {المجوهرات} : لاضهار عدد النقاط \n⇠ {التكليجات} : لاضهار عدد التكليجات \n⇠ {البوت} : لاضهار اسم البوت\n⇠ {المطور} : لاضهار معرف مطور الاساسي\n⇠ {تعليق} : لاضهار ردود عشوائيه .\n")
end
end

if redis:get(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..':Text_Start',msg.text)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اضافه كليشة الستارت  \n\n-ملاحظه : كليشة الستارت للمطور الاساسي تكون ثابته اما لغير الرتب تكون حسب الي وضعتها')
end


if redis:get(boss..'delrdall:'..msg.sender_user_id_) then
redis:del(boss..'delrdall:'..msg.sender_user_id_)
local names = redis:hget(boss..'replay:all',msg.text)
local photo =redis:hget(boss..'replay_photo:group:',msg.text)
local voice = redis:hget(boss..'replay_voice:group:',msg.text)
local animation = redis:hget(boss..'replay_animation:group:',msg.text)
local audio = redis:hget(boss..'replay_audio:group:',msg.text)
local sticker = redis:hget(boss..'replay_sticker:group:',msg.text)
local video = redis:hget(boss..'replay_video:group:',msg.text)
local file = redis:hget(boss..'replay_files:group:',msg.text)
if not (names or photo or voice or animation or audio or sticker or video or file) then
return sendMsg(msg.chat_id_,msg.id_,'⇠ هذا الرد ليس مضاف في قائمه الردود')
else
redis:hdel(boss..'replay:all',msg.text)
redis:hdel(boss..'replay_photo:group:',msg.text)
redis:hdel(boss..'replay_voice:group:',msg.text)
redis:hdel(boss..'replay_audio:group:',msg.text)
redis:hdel(boss..'replay_animation:group:',msg.text)
redis:hdel(boss..'replay_sticker:group:',msg.text)
redis:hdel(boss..'replay_video:group:',msg.text)
redis:hdel(boss..'replay_files:group:',msg.text)
return sendMsg(msg.chat_id_,msg.id_,'('..Flter_Markdown(msg.text)..')\n   تم مسحت الرد ')
end 
end 


if redis:get(boss..'text_sudo:witting'..msg.sender_user_id_) then -- استقبال كليشه المطور
redis:del(boss..'text_sudo:witting'..msg.sender_user_id_) 
redis:set(boss..':TEXT_SUDO',Flter_Markdown(msg.text))
return sendMsg(msg.chat_id_,msg.id_, "⇠ تم سويت الكليشه  \n\n*{*  "..Flter_Markdown(msg.text).."  *}* ")
end
if redis:get(boss..'text_sudo1:witting'..msg.sender_user_id_) then -- استقبال كليشه السورس
redis:del(boss..'text_sudo1:witting'..msg.sender_user_id_) 
redis:set(boss..':TEXT_SUDO1',Flter_Markdown(msg.text))
return sendMsg(msg.chat_id_,msg.id_, "⇠ تم سويت الكليشه  \n\n*{*  "..Flter_Markdown(msg.text).."  *}* ")
end
if redis:get(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_) then -- استقبال كليشه الترحيب
redis:del(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_) 
redis:set(boss..'welcome:msg'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم سويت الترحيب  " )
end
if redis:get(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال القوانين
redis:del(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_) 
redis:set(boss..'rulse:msg'..msg.chat_id_,Flter_Markdown(msg.text)) 
return sendMsg(msg.chat_id_,msg.id_,'- مرحبا عزيزي\n⇠ تم حفظ القوانين \n⇠ ارسل [[ القوانين ]] لعرضها ')
end
if redis:get(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال الاسم
redis:del(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_) 
tdcli_function({ID= "ChangeChatTitle",chat_id_=msg.chat_id_,title_=msg.text},dl_cb,nil)
end
if redis:get(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال الوصف
redis:del(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_) 
tdcli_function({ID="ChangeChannelAbout",channel_id_=msg.chat_id_:gsub('-100',''),about_ = msg.text},function(arg,data) 
if data.ID == "Ok" then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ تم سويت الوصف  \n")
end 
end,nil)
end


if redis:get(boss..'fwd:all'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه عام
redis:del(boss..'fwd:all'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')  
local groups = redis:smembers(boss..'group:ids')
local allgp =  #pv + #groups
if allgp >= 300 then
sendMsg(msg.chat_id_,msg.id_,'⇠ اهلا عزيزي المطور \n⇠ جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
for i = 1, #pv do 
sendMsg(pv[i],0,Flter_Markdown(msg.text))
end
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text))
end
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اذاعه الكليشه  \n⇠ للمـجمـوعات ↭ *'..#groups..'* قروب \n⇠ للمـشـتركين ↭ '..#pv..' مـشـترك  ')
end

if redis:get(boss..'fwd:pv'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:pv'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')
if #pv >= 300 then
sendMsg(msg.chat_id_,msg.id_,'⇠ اهلا عزيزي المطور \n⇠ جاري نشر الرساله للمشتركين ...')			
end
local NumPvDel = 0
for i = 1, #pv do
sendMsg(pv[i],0,Flter_Markdown(msg.text))
end
sendMsg(msg.chat_id_,msg.id_,'⇠ عدد المشتركين : '..#pv..'\n⇠ تم الاذاعه  \n') 
end

if redis:get(boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_)
local groups = redis:smembers(boss..'group:ids')
if #groups >= 300 then
sendMsg(msg.chat_id_,msg.id_,'⇠ اهلا عزيزي المطور \n⇠ جاري نشر الرساله للمجموعات ...')			
end
local NumGroupsDel = 0
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text),function(arg,data)
if data.chat_id_ then redis:setex(boss..":propin"..data.chat_id_,100,data.content_.text_) end
end)
end
sendMsg(msg.chat_id_,msg.id_,'⇠ عدد المجموعات  ‹ *'..#groups..'*   › \n⇠ تـم الاذاعه بالتثبيت  \n')
end 

if redis:get(boss..'fwd:groups'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:groups'..msg.sender_user_id_)
local groups = redis:smembers(boss..'group:ids')
if #groups >= 300 then
sendMsg(msg.chat_id_,msg.id_,'⇠ اهلا عزيزي المطور \n⇠ جاري نشر الرساله للمجموعات ...')			
end
local NumGroupsDel = 0
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text))
end
sendMsg(msg.chat_id_,msg.id_,'⇠ عدد المجموعات  ‹ *'..#groups..'*   › \n⇠ تـم الاذاعه  \n')
end 
end 

if msg.forward_info_ and redis:get(boss..'fwd:'..msg.sender_user_id_) then
redis:del(boss..'fwd:'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')
local groups = redis:smembers(boss..'group:ids')
local allgp =  #pv + #groups
if allgp == 500 then
sendMsg(msg.chat_id_,msg.id_,'⇠ اهلا عزيزي المطور \n⇠ جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
local number = 0
for i = 1, #pv do 
fwdMsg(pv[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
for i = 1, #groups do 
fwdMsg(groups[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم اذاعه التوجيه  \n⇠ للمـجمـوعات ↭ *'..#groups..'* \n⇠ للخاص ↭ '..#pv..'\n')			
end



if msg.text and msg.type == "channel" then
if msg.text:match("^"..Bot_Name.." اطلع$") and (msg.SudoBase or msg.SudoUser) then
sendMsg(msg.chat_id_,msg.id_,'ابشر ') 
rem_data_group(msg.chat_id_)
StatusLeft(msg.chat_id_,our_id)
return false
end
end

if msg.content_.ID == "MessagePhoto" and redis:get(boss..'welcom_ph:witting'..msg.sender_user_id_..msg.chat_id_) then
redis:del(boss..'welcom_ph:witting'..msg.sender_user_id_..msg.chat_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:set(boss..':WELCOME_BOT',photo_id)
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم تغيير صـوره‏‏ الترحيب للبوت ')
end 

if msg.content_.ID == "MessagePhoto" and msg.type == "channel" and msg.GroupActive then
if redis:get(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({ID="ChangeChatPhoto",chat_id_=msg.chat_id_,photo_=GetInputFile(photo_id)},function(arg,data)
if data.code_ == 3 then
sendMsg(arg.chat_id_,arg.id_,'⇠ ليس لدي صلاحيه تغيير الصوره \n⇠ يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ')
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
return false
end
end

--=============================================================================================================================
if msg.SudoUser and msg.text and redis:get(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_) then 
if not redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه كلمه الرد باكثر من 25 حرف ") end
redis:setex(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:setex(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_,1400,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"تمام , الحين ارسل جواب الرد \n ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )  \n ～")
end
end



if  msg.SudoUser and msg.text and redis:get(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
local DelRd = redis:del(boss..':ReplayRandom:'..msg.text) 
if DelRd == 0 then 
return sendMsg(msg.chat_id_,msg.id_,'⇠ هذا الرد مو مضاف في الردود العشوائيه اصلا ')
end
redis:del(boss..':caption_replay:Random:'..msg.text) 
redis:srem(boss..':KlmatRRandom:',msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم حذفت الرد  \n')
end
--=============================================================================================================================


if not msg.GroupActive then return false end
if msg.text then

if redis:get(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد للمجموعه بس

if not redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه كلمه الرد باكثر من 25 حرف ")
end
redis:setex(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:setex(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_,1400,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"تمام , الحين ارسل جواب الرد \n ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )  \n ～")
end
end


if redis:get(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد للمجموعه بس
if not redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"⇠ معليش غير مسموح باضافه كلمه الرد باكثر من 25 حرف ")
end
redis:hdel(boss..'replay:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_video:group:'..msg.chat_id_,msg.text)
redis:setex(boss..'replay1'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"تمام , الحين ارسل جواب الرد \n ( نص,صوره,فيديو,متحركه,بصمه,اغنيه )  \n ～")
end
end

if msg.text and redis:get(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_)
local DelRd = redis:del(boss..':ReplayRandom:'..msg.chat_id_..":"..msg.text) 
if DelRd == 0 then 
return sendMsg(msg.chat_id_,msg.id_,'⇠ هذا الرد مو مضاف في الردود العشوائيه اصلا ')
end
redis:del(boss..':caption_replay:Random:'..msg.chat_id_..msg.text) 
redis:srem(boss..':KlmatRRandom:'..msg.chat_id_,msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'⇠ تم حذفت الرد  \n')
end

if redis:get(boss..'delrd:'..msg.sender_user_id_) then
redis:del(boss..'delrd:'..msg.sender_user_id_)
local names 	= redis:hget(boss..'replay:'..msg.chat_id_,msg.text)
local photo 	= redis:hget(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
local voice 	= redis:hget(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
local animation = redis:hget(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
local audio 	= redis:hget(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
local files 	= redis:hget(boss..'replay_files:group:'..msg.chat_id_,msg.text)
local sticker 	= redis:hget(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
local video 	= redis:hget(boss..'replay_video:group:'..msg.chat_id_,msg.text)
if not (names or photo or voice or animation or audio or files or sticker or video) then
return sendMsg(msg.chat_id_,msg.id_,'⇠ هذا الرد ليس مضاف في قائمه الردود ')
else
redis:hdel(boss..'replay:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_files:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_video:group:'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..msg.text..'])\n   تم مسحت الرد ')
end 
end

end

if msg.content_.ID == "MessagePinMessage" then
print(" -- pinned -- ")
local msg_pin_id = redis:get(boss..":MsgIDPin:"..msg.chat_id_)
if not msg.Director and not msg.OurBot and redis:get(boss..'lock_pin'..msg.chat_id_) then
if msg_pin_id then
print(" -- pinChannelMessage -- ")
tdcli_function({ID ="PinChannelMessage",
channel_id_ = msg.chat_id_:gsub('-100',''),
message_id_ = msg_pin_id,
disable_notification_ = 0},
function(arg,data)
if data.ID == "Ok" then
sendMsg(arg.chat_id_,arg.id_,"⇠ معليش التثبيت مقفل من قبل الاداره تم ارجاع التثبيت القديم")
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
else
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},
function(arg,data) 
if data.ID == "Ok" then
sendMsg(msg.chat_id_,msg.id_,"⇠ معليش التثبيت مقفل من قبل الاداره تم الغاء التثبيت ")      
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
return false
end
redis:set(boss..":MsgIDPin:"..msg.chat_id_,msg.id_)
end

if msg.content_.ID == "MessageChatChangePhoto" then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end
sendMsg(msg.chat_id_,msg.id_," ⇠ قام  ["..UserName.."] بتغير صوره المجموعه  ")
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end

if msg.content_.ID == "MessageChatChangeTitle" then
GetUserID(msg.sender_user_id_,function(arg,data)
redis:set(boss..'group:name'..arg.chat_id_,arg.title_)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end
sendMsg(arg.chat_id_,arg.id_,"⇠ قام  ["..UserName.."]\n⇠ بتغير اسم المجموعه  \n⇠ الى "..Flter_Markdown(msg.content_.title_).." ") 
end,{chat_id_=msg.chat_id_,id_=msg.id_,title_=msg.content_.title_})
end

if msg.content_.ID == "MessageChatAddMembers" and redis:get(boss..'welcome:get'..msg.chat_id_) then
local adduserx = tonumber(redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
if adduserx > 3 then 
redis:del(boss..'welcome:get'..msg.chat_id_)
end
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',3,adduserx+1)
end

if (msg.content_.ID == "MessageChatAddMembers") then
if redis:get(boss..'welcome:get'..msg.chat_id_) then
if msg.adduserType then
welcome = (redis:get(boss..'welcome:msg'..msg.chat_id_) or "⇠ مرحباً عزيزي\n⇠ نورت المجموعة ")
welcome = welcome:gsub("{القوانين}", redis:get(boss..'rulse:msg'..msg.chat_id_) or "⇠ مرحبا عزيري القوانين  \n⇠ ممنوع نشر الروابط \n⇠ ممنوع التكلم او نشر صور اباحيه \n⇠ ممنوع اعاده توجيه \n⇠ ممنوع التكلم بلطائفه \n⇠ الرجاء احترام المدراء والادمنيه \n")
if msg.addusername then UserName = '@'..msg.addusername else UserName = '< مافيه يوزر >' end
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.adduser) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.adduser) or 0
local msgs = redis:get(boss..'msgs:'..msg.adduser..':'..msg.chat_id_) or 1

if msg.adduser == SUDO_ID then 
gtupe = 'Armando' 
elseif redis:sismember(boss..':SUDO_BOT:',msg.adduser) then 
gtupe = 'المطور'
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,msg.adduser) then 
gtupe = 'مالك'
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,msg.adduser) then 
gtupe = 'المالك'
elseif msg.GroupActive and redis:sismember(boss..'owners:'..msg.chat_id_,msg.adduser) then 
gtupe = 'المدير' 
elseif msg.GroupActive and redis:sismember(boss..'admins:'..msg.chat_id_,msg.adduser) then 
gtupe = 'الادمن'
elseif msg.GroupActive and redis:sismember(boss..'whitelist:'..msg.chat_id_,msg.adduser) then 
gtupe = 'عضو مميز'
elseif msg.adduser == our_id then
gtupe = "بوت"
else
gtupe = ' عضو '
end

welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{اليوزر}",UserName)
local welcome = welcome:gsub("{الايدي}",msg.adduser)
local welcome = welcome:gsub("{الرتبه}",gtupe)
local welcome = welcome:gsub("{التفاعل}",Get_Ttl(msgs))
local welcome = welcome:gsub("{الرسائل}",msgs)
local welcome = welcome:gsub("{المجوهرات}",points)
local welcome = welcome:gsub("{التكليجات}",edited)
local welcome = welcome:gsub("{البايو}",biouser)
local welcome = welcome:gsub("{البوت}",redis:get(boss..':NameBot:'))
local welcome = welcome:gsub("{المطور}",SUDO_USER)
local welcome = welcome:gsub("{تعليق}",RandomText())

local welcome = welcome:gsub("{الاسم}",FlterName(msg.addname,20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome))
return false
end 
end 
end 

if (msg.content_.ID == "MessageChatJoinByLink") then
if redis:get(boss..'welcome:get'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
welcome = (redis:get(boss..'welcome:msg'..msg.chat_id_) or "⇠ مرحباً عزيزي\n⇠ نورت المجموعة ")
welcome = welcome:gsub("{القوانين}", redis:get(boss..'rulse:msg'..msg.chat_id_) or "⇠ مرحبا عزيري القوانين  \n⇠ ممنوع نشر الروابط \n⇠ ممنوع التكلم او نشر صور اباحيه \n⇠ ممنوع اعاده توجيه \n⇠ ممنوع التكلم بلطائفه \n⇠ الرجاء احترام المدراء والادمنيه \n")
if data.username_ then UserName = '@'..data.username_ else UserName = '< مافيه يوزر >' end
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local msgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{اليوزر}",UserName)
local welcome = welcome:gsub("{الايدي}",msg.sender_user_id_)
local welcome = welcome:gsub("{الرتبه}",msg.TheRank)
local welcome = welcome:gsub("{التفاعل}",Get_Ttl(msgs))
local welcome = welcome:gsub("{الرسائل}",msgs)
local welcome = welcome:gsub("{المجوهرات}",points)
local welcome = welcome:gsub("{التكليجات}",edited)
local welcome = welcome:gsub("{البايو}",biouser)
local welcome = welcome:gsub("{البوت}",redis:get(boss..':NameBot:'))
local welcome = welcome:gsub("{المطور}",SUDO_USER)
local welcome = welcome:gsub("{تعليق}",RandomText())

local welcome = welcome:gsub("{الاسم}",FlterName(data.first_name_..' '..(data.last_name_ or "" ),20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome)) 
end)
end
return false
end

if msg.edited and not msg.SuperCreator and redis:get(boss.."antiedit"..msg.chat_id_) then 
if not msg.text then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local usersmnc   = ""
local NameUser   = Hyper_Link_Name(data)
if data.username_  then uuseri = "\n🔬꒐ يوزره : @["..data.username_.."]"  else uuseri = "" end
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
Rwers = ""
if msg.content_.ID == "MessagePhoto" then
Rwers = "صوره"
elseif msg.content_.ID == "MessageSticker"  then
Rwers = "ملصق"
elseif msg.content_.ID == "MessageVoice"  then
Rwers = "بصمه"
elseif msg.content_.ID == "MessageAudio"  then
Rwers = "صوت"
elseif msg.content_.ID == "MessageVideo"  then
Rwers = "فيديو"
elseif msg.content_.ID == "MessageAnimation"  then
Rwers = "متحركه"
else
Rwers = "نصي رابط"
end
if #monsha ~= 0 then 
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v) if info and info.username and info.username:match("@[%a%d_]+") then usersmnc = usersmnc..info.username.." - " end
sendMsg(v,0,"⇠ هناك شخص قام بالتعديل \n⇠ الاسم : ⋙「 "..NameUser.." 」 "..uuseri.."\n⇠ الايدي : `"..msg.sender_user_id_.."`\n⇠ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n⇠ نوع التعديل : "..Rwers.."\n⇠ المجموعة : "..Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')).."\n⇠ الرابط : "..redis:get(boss..'linkGroup'..msg.chat_id_).." " )
end
end
return sendMsg(msg.chat_id_,msg.id_,"⇠ نداء لمالكين : ["..usersmnc.."] \n⇠ هناك شخص قام بالتعديل"..uuseri.."\n⇠ الاسم : ⋙「 "..NameUser.." 」 \n⇠ الايدي : `"..msg.sender_user_id_.."`\n⇠ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n⇠ نوع التعديل : "..Rwers.."" )   

end,{msg=msg})
Del_msg(msg.chat_id_,msg.id_)
end
if (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text:match(".[Pp][Ee]") 
or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text:match("[Ww][Ww][Ww].") 
or msg.text:match(".[Cc][Oo][Mm]")) 
then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local usersmnc   = ""
local NameUser   = Hyper_Link_Name(data)
if data.username_  then uuseri = "\n🔬꒐ يوزره : @["..data.username_.."]"  else uuseri = "" end
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)

Rwers = "نصي رابط"

if #monsha ~= 0 then 
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v) if info and info.username and info.username:match("@[%a%d_]+") then usersmnc = usersmnc..info.username.." - " end
sendMsg(v,0,"⇠ هناك شخص قام بالتعديل \n⇠ الاسم : ⋙「 "..NameUser.." 」 "..uuseri.."\n⇠ الايدي : `"..msg.sender_user_id_.."`\n⇠ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n⇠ نوع التعديل : "..Rwers.."\n⇠ المجموعة : "..Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')).."\n⇠ الرابط : "..redis:get(boss..'linkGroup'..msg.chat_id_).." " )
end
end
return sendMsg(msg.chat_id_,msg.id_,"⇠ نداء لمالكين : ["..usersmnc.."] \n⇠ هناك شخص قام بالتعديل"..uuseri.."\n⇠ الاسم : ⋙「 "..NameUser.." 」 \n⇠ الايدي : `"..msg.sender_user_id_.."`\n⇠ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n⇠ نوع التعديل : "..Rwers.." " )   

end,{msg=msg})
Del_msg(msg.chat_id_,msg.id_)
end
end



if not msg.Admin and not msg.Special then -- للاعضاء بس  

if not msg.forward_info_ and msg.content_.ID ~= "MessagePhoto" and redis:get(boss..'lock_flood'..msg.chat_id_)  then
local msgs = (redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
local NUM_MSG_MAX = (redis:get(boss..'num_msg_max'..msg.chat_id_) or 5)
if tonumber(msgs) > tonumber(NUM_MSG_MAX) then 
redis:setex(boss..'sender:'..msg.sender_user_id_..':'..msg.chat_id_..'flood',30,true)
GetUserID(msg.sender_user_id_,function(arg,datau)
Restrict(arg.chat_id_,arg.sender_user_id_,1)
if datau.username_ then USERNAME = '@'..datau.username_ else USERNAME = FlterName(datau.first_name_..' '..(datau.last_name_ or "")) end
SendMention(arg.chat_id_,datau.id_,arg.id_,"⇠ الحلو ↭ "..USERNAME.."\n↫ تراك ازعجتنا وارسلت اكثر من "..arg.NUM_MSG_MAX.." رسايل , عشان كذا قيدناك يابثر‌‏ ✓ \n",14,utf8.len(USERNAME)) 
end,{chat_id_=msg.chat_id_,id_=msg.id_,NUM_MSG_MAX=NUM_MSG_MAX,sender_user_id_=msg.sender_user_id_})
return false
end 
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',2,msgs+1)
end


if msg.forward_info_ then
if redis:get(boss..'mute_forward'..msg.chat_id_) then -- قفل التوجيه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd \27[0m")

if data.ID == "Error" and data.code_ == 6 then 
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) and not redis:get(boss..':User_Fwd_Msg:'..msg.sender_user_id_..':flood') then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ معليش ممنوع اعادة التوجيه  ",14,utf8.len(USERNAME)) 
return redis:setex(boss..':User_Fwd_Msg:'..msg.sender_user_id_..':flood',15,true)
end,nil)
end
end)
return false
elseif redis:get(boss..':tqeed_fwd:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd tqeed \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false 
end
elseif msg.edited and msg.content_.ID ~= "MessageText" and redis:get(boss..'lock_edit'..msg.chat_id_) then -- قفل التعديل
Del_msg(msg.chat_id_,msg.id_,function(arg,data) 
print("\27[1;31m Msg Del becuse send Edit \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ معليشً ممنوع التعديل تم المسح ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif tonumber(msg.via_bot_user_id_) ~= 0 and redis:get(boss..'mute_inline'..msg.chat_id_) then -- قفل الانلاين
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send inline \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ معليش الانلاين مقفول  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text then -- رسايل بس
if utf8.len(msg.text) > 500 and redis:get(boss..'lock_spam'..msg.chat_id_) then -- قفل الكليشه 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send long msg \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الكليشه والا سوف تجبرني على طردك  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text:match(".[Pp][Ee]") 
or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text:match("[Ww][Ww][Ww].") 
or msg.text:match(".[Cc][Oo][Mm]")) 
and redis:get(boss..':tqeed_link:'..msg.chat_id_)  then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user i restricted becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false
elseif (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Oo][Rr][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match(".[Pp][Ee]")) 
and redis:get(boss..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الروابط  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Tt][Kk]") or msg.text:match(".[Mm][Ll]") or msg.text:match(".[Oo][Rr][Gg]")) and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال روابط الويب   ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("ی") or msg.text:match('چ') or msg.text:match('گ') or msg.text:match('ک') or msg.text:match('پ') or msg.text:match('ژ') or msg.text:match('ٔ') or msg.text:match('۴') or msg.text:match('۵') or msg.text:match('۶')) and redis:get(boss.."lock_pharsi"..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send lock_pharsi \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الفارسيه  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif redis:get(boss.."lock_mmno3"..msg.chat_id_) and KlmatMmno3(msg.text)  then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send mseeea \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الكلمات المسيئه  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("[a-zA-Z]") and redis:get(boss.."lock_lang"..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send En \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الانقليزيه  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("#.+") and redis:get(boss..'lock_tag'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send tag \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال التاك  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("@[%a%d_]+")  and redis:get(boss..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال اليوزر   ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif not msg.textEntityTypeBold and (msg.textEntityTypeBold or msg.textEntityTypeItalic) and redis:get(boss..'lock_markdown'..msg.chat_id_) then 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send markdown \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ارسال الماركدوان  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.textEntityTypeTextUrl and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web page \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ .ممنوع ارسال روابط الويب   ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
end 
elseif msg.content_.ID == "MessageUnsupported" and redis:get(boss..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الفيديو كام ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessagePhoto" then
if redis:get(boss..'mute_photo'..msg.chat_id_)  then -- قفل الصور
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الصور  ",14,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif redis:get(boss..':tqeed_photo:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user resctricted becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageVideo" then
if redis:get(boss..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send vedio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الفيديو  ",14,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif redis:get(boss..':tqeed_video:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageDocument" and redis:get(boss..'mute_document'..msg.chat_id_) then -- قفل الملفات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send file \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الملفات  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageSticker" and redis:get(boss..'mute_sticker'..msg.chat_id_) then --قفل الملصقات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send sticker \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الملصقات  ",14,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif msg.content_.ID == "MessageAnimation" then
if redis:get(boss..'mute_gif'..msg.chat_id_) then -- قفل المتحركه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الصور المتحركه  ",14,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif redis:get(boss..':tqeed_gif:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageContact" and redis:get(boss..'mute_contact'..msg.chat_id_) then -- قفل الجهات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send Contact \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME..'\n⇠ ممنوع ترسل جهات الاتصال  ',14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageLocation" and redis:get(boss..'mute_location'..msg.chat_id_) then -- قفل الموقع
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send location \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الموقع  ",14,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageVoice" and redis:get(boss..'mute_voice'..msg.chat_id_) then -- قفل البصمات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send voice \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل فويسات  ",14,utf8.len(USERNAME))
end,nil)   
end
end)
return false
elseif msg.content_.ID == "MessageGame" and redis:get(boss..'mute_game'..msg.chat_id_) then -- قفل الالعاب
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send game \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ معليش ممنوع لعب الالعاب  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageAudio" and redis:get(boss..'mute_audio'..msg.chat_id_) then -- قفل الصوت
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send audio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الصوت  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.reply_markup and  msg.reply_markup.ID == "replyMarkupInlineKeyboard" and redis:get(boss..'mute_keyboard'..msg.chat_id_) then -- كيبورد
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send keyboard \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ معليش الكيبورد مقفول  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
end

if msg.content_.caption_ then -- الرسايل الي بالكابشن
if (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.content_.caption_:match("[Tt].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match(".[Pp][Ee]")) 
and redis:get(boss..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل الروابط  ",14,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") 
or msg.content_.caption_:match("[Ww][Ww][Ww].") 
or msg.content_.caption_:match(".[Cc][Oo][Mm]")) 
and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send webpage caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل روابط الويب  ",14,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif msg.content_.caption_:match("@[%a%d_]+") and redis:get(boss..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مقدر مسح الرساله المخالفه .\n⇠ لست مشرف او ليس لدي صلاحيه الحذف  ')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"⇠ الحلو ↭ "..USERNAME.."\n⇠ ممنوع ترسل التاك او اليوزر  ",14,utf8.len(USERNAME))
end,nil)
end 
end)
return false
end 


end --========{ End if } ======

end 
SaveNumMsg(msg)

if msg.text then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg



if redis:get(boss.."lock_RandomRdod"..msg.chat_id_) then 
local Replay = 0
Replay = redis:smembers(boss..':ReplayRandom:'..msg.text) 
if #Replay ~= 0 then 
local Replay = Replay[math.random(#Replay)]
Replay = convert_Klmat(msg,data,Replay,true)
local CaptionFilter = Replay:gsub(":Text:",""):gsub(":Document:",""):gsub(":Voice:",""):gsub(":Photo:",""):gsub(":Animation:",""):gsub(":Audio:",""):gsub(":Sticker:",""):gsub(":Video:","")
Caption = redis:hget(boss..':caption_replay:Random:'..msg.text,CaptionFilter)
Caption = convert_Klmat(msg,data,Caption)
if Replay:match(":Text:") then
return sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay:gsub(":Text:","")))
elseif Replay:match(":Document:") then 
return sendDocument(msg.chat_id_,msg.id_,Replay:gsub(":Document:",""),Caption)  
elseif Replay:match(":Photo:") then 
return sendPhoto(msg.chat_id_,msg.id_,Replay:gsub(":Photo:",""),Caption)  
elseif Replay:match(":Voice:") then 
return sendVoice(msg.chat_id_,msg.id_,Replay:gsub(":Voice:",""),Caption)
elseif Replay:match(":Animation:") then 
return sendAnimation(msg.chat_id_,msg.id_,Replay:gsub(":Animation:",""),Caption)  
elseif Replay:match(":Audio:") then 
return sendAudio(msg.chat_id_,msg.id_,Replay:gsub(":Audio:",""),"",Caption)  
elseif Replay:match(":Sticker:") then 
return sendSticker(msg.chat_id_,msg.id_,Replay:gsub(":Sticker:",""))  
elseif Replay:match(":Video:") then 
return sendVideo(msg.chat_id_,msg.id_,Replay:gsub(":Video:",""),Caption)
end
end


local Replay = 0
Replay = redis:smembers(boss..':ReplayRandom:'..msg.chat_id_..":"..msg.text) 
if #Replay ~= 0 then 
local Replay = Replay[math.random(#Replay)]
Replay = convert_Klmat(msg,data,Replay,true)
local CaptionFilter = Replay:gsub(":Text:",""):gsub(":Document:",""):gsub(":Voice:",""):gsub(":Photo:",""):gsub(":Animation:",""):gsub(":Audio:",""):gsub(":Sticker:",""):gsub(":Video:","")
Caption = redis:hget(boss..':caption_replay:Random:'..msg.chat_id_..msg.text,CaptionFilter)
Caption = convert_Klmat(msg,data,Caption)
if Replay:match(":Text:") then
return sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay:gsub(":Text:","")))
elseif Replay:match(":Document:") then 
return sendDocument(msg.chat_id_,msg.id_,Replay:gsub(":Document:",""),Caption)  
elseif Replay:match(":Photo:") then 
return sendPhoto(msg.chat_id_,msg.id_,Replay:gsub(":Photo:",""),Caption)  
elseif Replay:match(":Voice:") then 
return sendVoice(msg.chat_id_,msg.id_,Replay:gsub(":Voice:",""),Caption)
elseif Replay:match(":Animation:") then 
return sendAnimation(msg.chat_id_,msg.id_,Replay:gsub(":Animation:",""),Caption)  
elseif Replay:match(":Audio:") then 
return sendAudio(msg.chat_id_,msg.id_,Replay:gsub(":Audio:",""),"",Caption)  
elseif Replay:match(":Sticker:") then 
return sendSticker(msg.chat_id_,msg.id_,Replay:gsub(":Sticker:",""))  
elseif Replay:match(":Video:") then 
return sendVideo(msg.chat_id_,msg.id_,Replay:gsub(":Video:",""),Caption)
end
end

end

if redis:get(boss..'replay'..msg.chat_id_) then
local Replay = false

Replay = redis:hget(boss..'replay:all',msg.text)
if Replay then
Replay = convert_Klmat(msg,data,Replay,true)
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay))
return false
end

Replay = redis:hget(boss..'replay:'..msg.chat_id_,msg.text)
if Replay then 
Replay = convert_Klmat(msg,data,Replay,true)
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay)) 
return false
end

Replay = redis:hget(boss..'replay_photo:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
print(Caption)
sendPhoto(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_voice:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVoice(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_animation:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAnimation(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_audio:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAudio(msg.chat_id_,msg.id_,Replay,"",Caption)  
return false
end


Replay = redis:hget(boss..'replay_files:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendDocument(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_files:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendDocument(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_sticker:group:',msg.text)
if Replay then 
sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(boss..'replay_video:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:',msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVideo(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendPhoto(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVoice(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAnimation(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAudio(msg.chat_id_,msg.id_,Replay,"",Caption)  
return false
end

Replay = redis:hget(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
if Replay then 
sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(boss..'replay_video:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVideo(msg.chat_id_,msg.id_,Replay,Caption)
return false
end
end

end,{msg=msg})


------------------------------{ Start Replay Send }------------------------



end

if msg.text and redis:get(boss.."lock_rdodSource"..msg.chat_id_) then

--================================{{  Reply Bot  }} ===================================



if msg.SudoUser and Text == Bot_Name and not Text2 then
return sendMsg(msg.chat_id_,msg.id_,su[math.random(#su)])
elseif not msg.SudoUser and Text== Bot_Name and not Text2 then  
return sendMsg(msg.chat_id_,msg.id_,ss97[math.random(#ss97)])
elseif Text:match("^قول (.*)$") then
if utf8.len(Text:match("^قول (.*)$")) > 1000 then 
return sendMsg(msg.chat_id_,msg.id_," للاسف ماقدر اقول اكثر من 1000 حرف ")
end
local callback_Text = FlterName(Text:match("^قول (.*)$"),1000)
if callback_Text and callback_Text == 'الاسم سبام ' then
return sendMsg(msg.chat_id_,msg.id_,"- للاسف النص هذا مخالف ")
else
return sendMsg(msg.chat_id_,0,callback_Text) 
end



elseif Text=="رابط الحذف" or Text=="رابط الحذف" or Text=="رابط حذف" or Text=="رابط الحذف" then
return sendMsg(msg.chat_id_,msg.id_,[[
رابط حذف حـساب التليجرام ↯
 فكر لاتستعجل  
 بالتوفيق ..
  https://telegram.org/deactivate
]] )
elseif Text== "" or Text== "" or Text=="" then
if msg.SudoUser then  
return sendMsg(msg.chat_id_,msg.id_,"")
end 
end 


end


------------------------------{ End Replay Send }------------------------

------------------------------{ Start Checking CheckExpire }------------------------

if redis:get(boss..'CheckExpire::'..msg.chat_id_) then
local ExpireDate = redis:ttl(boss..'ExpireDate:'..msg.chat_id_)
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "\n⇠ راسل المطور للتجديد ["..SUDO_USER.."]"
else
SUDO_USERR = ""
end
if not ExpireDate and not msg.SudoUser then
rem_data_group(msg.chat_id_)
sendMsg(SUDO_ID,0,'⇠ انتهى الاشتراك في احد المجموعات \n⇠ المجموعه : '..FlterName(redis:get(boss..'group:name'..msg.chat_id_))..'\n⇠ ايدي : '..msg.chat_id_)
sendMsg(msg.chat_id_,0,'⇠ انتهى الاشتراك البوت\n⇠ سوف اغادر المجموعه فرصه سعيده '..SUDO_USERR..' ')
return StatusLeft(msg.chat_id_,our_id)
else
local DaysEx = (redis:ttl(boss..'ExpireDate:'..msg.chat_id_) / 86400)
if tonumber(DaysEx) > 0.208 and ExpireDate ~= -1 and msg.Admin then
if tonumber(DaysEx + 1) == 1 and not msg.SudoUser then
sendMsg(msg.chat_id_,'- باقي يوم واحد وينتهي الاشتراك \n '..SUDO_USERR..'')
end 
end 
end
end

------------------------------{ End Checking CheckExpire }------------------------
function Get_Info(msg,chat,user) --// ارسال نتيجة الصلاحيه
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
return sendMsg(msg.chat_id_,msg.id_,'⇠ صلاحياته مالك اساسي المجموعه\n')   
end 
if Json_Info.result.status == "member" then
return sendMsg(msg.chat_id_,msg.id_,'⇠ مجرد عضو هنا\n')   
end 
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔ ' else info = '✖' end
if Json_Info.result.can_delete_messages == true then
delete = '✔ ' else delete = '✖' end
if Json_Info.result.can_invite_users == true then
invite = '✔ ' else invite = '✖' end
if Json_Info.result.can_pin_messages == true then
pin = '✔ ' else pin = '✖' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔ ' else restrict = '✖' end
if Json_Info.result.can_promote_members == true then
promote = '✔ ' else promote = '✖' end
return sendMsg(chat,msg.id_,'⇠ الرتبة : مشرف \n⇠ والصلاحيات هي ⇓ \nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n⇠ تغير معلومات المجموعه ↞ ❪ '..info..' ❫\n⇠ حذف الرسائل ↞ ❪ '..delete..' ❫\n⇠ حظر الحلوين ↞ ❪ '..restrict..' ❫\n⇠ دعوة مستخدمين ↞ ❪ '..invite..' ❫\n⇠ تثبيت الرسائل ↞ ❪ '..pin..' ❫\n⇠ اضافة مشرفين جدد ↞ ❪ '..promote..' ❫\n\n⇠ ملاحضه » علامة ❪  ✔  ❫ تعني لديه الصلاحية وعلامة ❪ ✖ ❫ تعني ليس ليديه الصلاحيه')   
end
end
end

 

end 

return {
Boss = {
"^(اضف رد عشوائي)$",
"^(مسح رد عشوائي)$",
"^(مسح الردود العشوائيه)$",
"^(الردود العشوائيه)$",
"^(اضف رد عشوائي عام)$",
"^(مسح رد عشوائي عام)$",
"^(مسح الردود العشوائيه العامه)$",
"^(الردود العشوائيه العام)$",
"^(مسح المطورين)$",
"^(مسح قائمه العام)$",
"^(مسح الادمنيه)$",

"^(مسح المالكين الاساسين)$",
"^(حذف المالكين الاساسين)$",
"^(مسح المالكيين الاساسيين)$",
"^(مسح المالكيين الاساسين)$",
"^(حذف المالكين)$",
"^(مسح المالكين)$",
"^(مسح المالكيين)$",
"^(مسح المنشئيين الاساسين)$",
"^(مسح الرسائل المجدوله)$",
"^(مسح الميديا)$",
"^(مسح الوسائط)$",
"^(مسح التعديلات)$",
"^(مسح تكليجاتي)$",
"^(مسح تعديلاتي)$",
"^(مسح قائمه المنع)$",
"^(مسح القوانين)$",
"^(مسح الترحيب)$",
"^(مسح المالكين)$",
"^(مسح المالكيين)$",
"^(مسح المدراء)$",
"^(مسح المحظورين)$",
"^(مسح المكتومين)$",
"^(مسح المميزين)$",
"^(مسح التيوس)$",
"^(مسح القلوب)$",
"^(مسح الوتك)$",
"^(مسح زوجاتي)$",
"^(مسح ازواجي)$",
"^(مسح الرابط)$",

"^(مسح قائمه الرتب)$",
"^(مسح الرتب)$",
"^(مسح الرتبه)$",
"^(مسح رتبه)$",
"^(تغير الرتبه)$",
"^(تغير رتبه)$",
"^(قائمه الرتب)$",
"^(المالك اساسي)$",
"^(المنشئ)$",
"^(المالك)$",
"^(رفع القيود)$",
"^(رفع القيود) (%d+)$",
"^(رفع القيود) (@[%a%d_]+)$",
"^(تقييد) (%d+)$",
"^(تقييد) (@[%a%d_]+)$",
"^(فك التقييد) (%d+)$",
"^(فك التقييد) (@[%a%d_]+)$",
"^(فك تقييد) (%d+)$",
"^(فك تقييد) (@[%a%d_]+)$",
"^(ضع شرط التفعيل) (%d+)$",
"^(التفاعل) (@[%a%d_]+)$",
"^(التفاعل) (%d+)$",
"^(ايدي) (@[%a%d_]+)$",
"^(ايديي) (@[%a%d_]+)$",
"^(كشف) (%d+)$",
"^(كشف) (@[%a%d_]+)$",
'^(رفع مميز) (@[%a%d_]+)$',
'^(رفع مميز) (%d+)$',
'^(رفع تيس) (@[%a%d_]+)$',
'^(رفع تيس) (%d+)$',
'^(تنزيل تيس) (@[%a%d_]+)$', 
'^(تنزيل تيس) (%d+)$',
'^(رفع قلبي) (@[%a%d_]+)$',
'^(رفع قلبي) (%d+)$',
'^(تنزيل قلبي) (@[%a%d_]+)$', 
'^(تنزيل قلبي) (%d+)$',
'^(رفع وتكه) (@[%a%d_]+)$',
'^(رفع وتكه) (%d+)$',
'^(تنزيل وتكه) (@[%a%d_]+)$', 
'^(تنزيل وتكه) (%d+)$',
'^(رفع زوجي) (@[%a%d_]+)$',
'^(رفع زوجي) (%d+)$',
'^(تنزيل زوجي) (@[%a%d_]+)$', 
'^(تنزيل زوجي) (%d+)$',
'^(رفع زوجتي) (@[%a%d_]+)$',
'^(رفع زوجتي) (%d+)$',
'^(تنزيل زوجتي) (@[%a%d_]+)$', 
'^(تنزيل زوجتي) (%d+)$',
'^(تنزيل الكل) (@[%a%d_]+)$',
'^(تنزيل الكل) (%d+)$',
'^(تنزيل مميز) (@[%a%d_]+)$',
'^(تنزيل مميز) (%d+)$',
'^(رفع ادمن) (@[%a%d_]+)$',
'^(رفع ادمن) (%d+)$',
'^(تنزيل ادمن) (@[%a%d_]+)$',
'^(تنزيل ادمن) (%d+)$', 
'^(رفع مدير) (@[%a%d_]+)$',
'^(رفع المدير) (@[%a%d_]+)$',
'^(رفع المدير) (%d+)$',
'^(رفع مدير) (%d+)$',
'^(رفع منشئ) (@[%a%d_]+)$',
'^(رفع منشى) (%d+)$',
'^(رفع منشئ) (%d+)$',
'^(رفع منشى) (@[%a%d_]+)$',
'^(رفع مشرف) (@[%a%d_]+)$',
'^(تنزيل مشرف)$',
'^(تنزيل مشرف) (%d+)$',
'^(رفع مشرف)$',
'^(رفع مشرف) (%d+)$',
'^(تنزيل منشئ) (%d+)$',
'^(تنزيل منشى) (%d+)$',
'^(تنزيل مشرف) (@[%a%d_]+)$',
'^(تنزيل منشى) (@[%a%d_]+)$',
'^(تنزيل منشئ) (@[%a%d_]+)$',
'^(تنزيل مدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (%d+)$',
'^(تنزيل مدير) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(ضع وقت التنظيف) (%d+)$',
"^(مسح)$",
"^(مسح) (.+)$",
'^(منع) (.+)$',
'^(الغاء منع) (.+)$',
"^(حظر عام) (@[%a%d_]+)$",
"^(حظر عام) (%d+)$",
"^(الغاء العام) (@[%a%d_]+)$",
"^(الغاء العام) (%d+)$",
"^(الغاء عام) (@[%a%d_]+)$",
"^(الغاء عام) (%d+)$",
"^(حظر) (@[%a%d_]+)$",
"^(حظر) (%d+)$",
"^(الغاء الحظر) (@[%a%d_]+)$",
"^(الغاء الحظر) (%d+)$",
"^(الغاء حظر) (@[%a%d_]+)$",
"^(الغاء حظر) (%d+)$",
"^(طرد) (@[%a%d_]+)$",
"^(طرد) (%d+)$",
"^(كتم) (@[%a%d_]+)$",
"^(كتم) (%d+)$",
"^(الغاء الكتم) (@[%a%d_]+)$",
"^(الغاء الكتم) (%d+)$",
"^(الغاء كتم) (@[%a%d_]+)$",
"^(الغاء كتم) (%d+)$",
"^(رفع مطور) (@[%a%d_]+)$",
"^(رفع مطور) (%d+)$",
"^(تنزيل مطور) (%d+)$",
"^(تنزيل مطور) (@[%a%d_]+)$",
"^(رفع مالك) (@[%a%d_]+)$",
"^(رفع مالك) (%d+)$",
"^(تنزيل مالك) (@[%a%d_]+)$",
"^(تنزيل مالك) (%d+)$",

"^(رفع المالك) (@[%a%d_]+)$",
"^(رفع المالك) (%d+)$",
"^(تنزيل المالك) (@[%a%d_]+)$",
"^(تنزيل المالك) (%d+)$",


"^(الاشتراك) ([123])$",
"^(شحن) (%d+)$",
"^(تعيين امر) (.*)$",
"^(تغير امر) (.*)$",
"^(تعين امر) (.*)$",
"^(اضف امر) (.*)$",
"^(اضف امر)$",
"^(مسح امر) (.*)$",
"^(مسح امر)$",

"^([Ss][pP]) ([%a%d_]+.lua)$", 
"^([dD][pP]) ([%a%d_]+.lua)$", 


"^(@all)$",
"^(منشن للكل)$",
"^(منشن للكل) (ل %d+)$",
"^(تاق للكل)$",
"^(تاق للكل) (ل %d+)$",
"^(منشن)$",
"^(منشن) (ل %d+)$",
"^(تاق)$",
"^(تاق) (ل %d+)$",
"^(الادارين)$",
"^(الاداريين)$",
"^(الاداريين)$",
"^(الادارين)$",

"^(تنزيل الكل)$",
"^(تقييد)$",
"^(فك التقييد)$",
"^(فك تقييد)$",
"^(التفاعل)$",
"^([iI][dD])$",
"^(ايدي)$",
"^(ايديي)$",
"^(كشف)$",
'^(رفع مميز)$',
'^(تنزيل مميز)$',
'^(رفع تيس)$',
'^(تنزيل تيس)$',
'^(رفع قلبي)$',
'^(تنزيل قلبي)$',
'^(رفع وتكه)$',
'^(تنزيل وتكه)$',
'^(رفع زوجتي)$',
'^(تنزيل زوجتي)$',
'^(رفع زوجي)$',
'^(تنزيل زوجي)$',
'^(رفع ادمن)$',
'^(تنزيل ادمن)$', 
'^(رفع المدير)$',
'^(رفع مدير)$',
'^(رفع منشى)$',
'^(المالكين الاساسيين)$',
'^(مسح المالكين اساسيين)$',
'^(رفع مالك اساسي)$',
'^(رفع مالك اساسي) (%d+)$',
'^(رفع مالك اساسي) (@[%a%d_]+)$',
'^(تنزيل مالك اساسي)$',
'^(تنزيل مالك اساسي) (%d+)$',
'^(تنزيل مالك اساسي) (@[%a%d_]+)$',
'^(رفع منشئ)$',
'^(تنزيل منشئ)$',
'^(تنزيل منشى)$',
'^(تنزيل المدير)$',
'^(تنزيل مدير)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(تعطيل) [-]100(%d+)$',

"^(مسح كلايش التعليمات)$",



"^(تعديلاتي)$",
"^(تكليجاتي)$",
"^(تعين الايدي)$",
"^(تعيين ايدي)$",
"^(تعيين كليشه الستارت)$",
"^(مسح كليشه الستارت)$",
"^(تعيين كليشه الايدي عام)$",
"^(تعيين ايدي عام)$",

"^(تعيين كليشة الايدي)$",
"^(تعيين الايدي)$",
"^(حظر عام)$",
"^(الغاء العام)$",
"^(الغاء عام)$",
"^(حظر)$",
"^(الغاء الحظر)$",
"^(الغاء حظر)$",
"^(طرد)$",
"^(كتم)$",
"^(الغاء الكتم)$",
"^(الغاء كتم)$",
"^(رفع مطور)$",
"^(تنزيل مطور)$",
"^(رفع مالك)$",
"^(تنزيل مالك)$",
"^(رفع المالك)$",
"^(تنزيل المالك)$",
"^(تعيين قائمه الاوامر)$",
"^(الاشتراك)$",
"^(المجموعه)$",
"^(كشف البوت)$",
"^(انشاء رابط)$",
"^(ضع الرابط)$",
"^(تثبيت)$",
"^(الغاء التثبيت)$",
"^(الغاء تثبيت)$",
"^(مسح قائمه التثبيت)$",
"^(مسح قائمه تثبيت)$",
"^(مسح التثبيتات)$",
"^(رابط)$",
"^(الرابط)$",
"^(القوانين)$",
"^(ضع القوانين)$",
"^(ضع قوانين)$",
"^(ضع تكرار)$",
"^(ضع التكرار)$",
"^(المالكيين)$",
"^(المالكين)$",
"^(الادمنيه)$",
"^(قائمه المنع)$",
"^(المدراء)$",
"^(المميزين)$",
"^(قائمه التيوس)$",
"^(قائمه القلوب)$",
"^(قائمه الوتك)$",
"^(قائمه زوجاتي)$",
"^(قائمه ازواجي)$",
"^(المكتومين)$",
"^(ضع الترحيب)$",
"^(الترحيب)$",
"^(المحظورين)$",
"^(ضع اسم)$",
"^(ضع صوره)$",
"^(ضع وصف)$",
"^(طرد البوتات)$",
"^(كشف البوتات)$",
"^(طرد المحذوفين)$",
"^(رسائلي)$",
"^(رسايلي)$",
"^(احصائياتي)$",
"^(معلوماتي)$",
"^(موقعي)$",
"^(رفع الادمنيه)$",
"^(صوره الترحيب)$",
"^(ضع كليشه المطور)$",
"^(مسح كليشه المطور)$",
"^(المطور)$",
"^(ضع كليشه السورس)$",
"^(مسح كليشه السورس)$",
"^(شرط التفعيل)$",
"^(قائمه المجموعات)$",
"^(المجموعات)$",
"^(اذاعه)$",
"^(اذاعه عام)$",
"^(اذاعه خاص)$",
"^(اذاعه عام بالتوجيه)$", 
"^(اذاعه)$", 
"^(قائمه العام)$",
"^(المطورين)$",
"^(تيست)$",
"^(test)$",
"^(قناة السورس)$",
"^(الاحصائيات)$",
"^(اضف رد عام)$",
"^(مسح الردود)$",
"^(مسح الردود العامه)$",
"^(ضع اسم للبوت)$",
"^(حذف صوره)$",
"^(مسح رد)$",
"^(الردود)$",
"^(الردود العامه)$",
"^(اضف رد)$",
"^(/UpdateSource)$",
"^(تحديث السورس)$",
"^(تنظيف المجموعات)$",
"^(تنظيف المشتركين)$",
"^(رتبتي)$",
"^(ضع اسم للبوت)$",
"^(ضع صوره للترحيب)$",
"^(الحمايه)$",
"^(الاعدادات)$",
"^(الوسائط)$",
"^(الغاء الامر)$",
"^(الرتبه)$",
"^(الغاء)$",
"^(الساعه)$",
"^(التاريخ)$",

"^(الملفات)$",
"^(اصدار السورس)$",
"^(الاصدار)$",
"^(server)$",
"^(تعيين امر)$",
"^(تغير امر)$",
"^(تعين امر)$",
"^(السيرفر)$",
"^(اذاعه بالتثبيت)$",
"^(نسخه احتياطيه للمجموعات)$",
"^(رفع نسخه الاحتياطيه)$", 

"^(تعطيل الردود العشوائيه)$", 
"^(تفعيل الردود العشوائيه)$", 
"^(تفعيل ردود السورس)$", 
"^(تعطيل ردود السورس)$", 
"^(تفعيل التنظيف التلقائي)$", 
"^(تعطيل التنظيف التلقائي)$", 

"^(تفعيل الاشتراك الاجباري)$", 
"^(تعطيل الاشتراك الاجباري)$", 
"^(تغيير الاشتراك الاجباري)$", 
"^(الاشتراك الاجباري)$", 
"^(ادفرني)$", 
"^(مغادره)$", 
"^(قائمه الاوامر)$", 
"^(مسح الاوامر)$", 
"^(احظرني)$", 
"^(اطردني)$", 
"^(جهاتي)$", 
"^(ضع رابط)$", 
"^(نقل ملكيه البوت)$", 
"^(مسح كليشه الايدي)$", 
"^(مسح الايدي)$", 
"^(مسح ايدي)$", 
"^(مسح كليشة الايدي)$", 
"^(مسح كليشه الايدي عام)$", 
"^(مسح الايدي عام)$", 
"^(مسح ايدي عام)$", 
"^(مسح كليشة الايدي عام)$", 
"^(التسليه)$",
"^(التسلية)$",
"^(السورس)$",
"^(سورس)$",
"^(اعدادات المجموعة)$",
"^(اعدادات المجموعه)$",
"^(م4)$", 
"^(م6)$",
"^(م5)$",
"^(الاوامر)$",
"^(الاوامر خاص)$",
  "^(مسح معلوماتي)$",
"^(/Commands)$",
"^(/Commands@He82Bot)$",
"^(م1)$",
"^(م2)$",
"^(م3)$", 
"^(م المطور)$",
"^(اوامر الرد)$",
"^(/store)$", 
"^(/files)$", 
"^(قفل الصور بالتقييد)$",
"^(قفل الفيديو بالتقييد)$",
"^(قفل المتحركه بالتقييد)$",
"^(قفل التوجيه بالتقييد)$",
"^(قفل الروابط بالتقييد)$",
"^(قفل الدردشه)$",
"^(قفل المتحركه)$",
"^(قفل الصور)$",
"^(قفل الفيديو)$",
"^(قفل البصمات)$",
"^(قفل الصوت)$",
"^(قفل الملصقات)$",
"^(قفل الجهات)$",
"^(قفل التوجيه)$",
"^(قفل الموقع)$",
"^(قفل الملفات)$",
"^(قفل الاشعارات)$",
"^(قفل الانلاين)$",
"^(قفل الالعاب)$",
"^(قفل الكيبورد)$",
"^(قفل الروابط)$",
"^(قفل التاك)$",
"^(قفل المعرفات)$",
"^(قفل التعديل)$",
"^(قفل الكلايش)$",
"^(قفل التكرار)$",
"^(قفل البوتات)$",
"^(قفل البوتات بالطرد)$",
"^(قفل الماركدوان)$",
"^(قفل الويب)$",
"^(قفل التثبيت)$",
"^(قفل الاضافه)$",
"^(قفل الانقليزيه)$",
"^(قفل الفارسيه)$",
"^(قفل السب)$",
"^(فتح الصور بالتقييد)$",
"^(فتح الفيديو بالتقييد)$",
"^(فتح المتحركه بالتقييد)$",
"^(فتح التوجيه بالتقييد)$",
"^(فتح الروابط بالتقييد)$",
"^(فتح الدردشه)$",
"^(فتح المتحركه)$",
"^(فتح الصور)$",
"^(فتح الفيديو)$",
"^(فتح البصمات)$",
"^(فتح الصوت)$",
"^(فتح الملصقات)$",
"^(فتح الجهات)$",
"^(فتح التوجيه)$",
"^(فتح الموقع)$",
"^(فتح الملفات)$",
"^(فتح الاشعارات)$",
"^(فتح الانلاين)$",
"^(فتح الالعاب)$",
"^(فتح الكيبورد)$",
"^(فتح الروابط)$",
"^(فتح التاك)$",
"^(فتح المعرفات)$",
"^(فتح التعديل)$",
"^(فتح الكلايش)$",
"^(فتح التكرار)$",
"^(فتح البوتات)$",
"^(فتح البوتات بالطرد)$",
"^(فتح الماركدوان)$",
"^(فتح الويب)$",
"^(فتح التثبيت)$",
"^(فتح الاضافه)$",
"^(فتح الانقليزيه)$",
"^(فتح الفارسيه)$",
"^(فتح السب)$",
"^(تعطيل الردود)$",
"^(تعطيل الاذاعه)$",
"^(تعطيل الايدي)$",
"^(تعطيل الترحيب)$",
"^(تعطيل التحذير)$",
"^(تعطيل الايدي بالصوره)$",
"^(تعطيل الحمايه)$",
"^(تعطيل المغادره)$",
"^(تعطيل اطردني)$",
"^(تعطيل تعيين الايدي)$",
"^(تعطيل الحظر)$",
"^(تعطيل الرابط)$",
"^(تعطيل المنشن)$",
"^(تعطيل التحقق)$",
"^(تفعيل الردود)$",
"^(تفعيل الاذاعه)$",
"^(تفعيل الايدي)$",
"^(تفعيل الترحيب)$",
"^(تفعيل التحذير)$",
"^(تفعيل الايدي بالصوره)$",
"^(تفعيل الحمايه)$",
"^(تفعيل المغادره)$",
"^(تفعيل اطردني)$",
"^(تفعيل تعيين الايدي)$",
"^(تفعيل الحظر)$",
"^(تفعيل الرابط)$",
"^(تفعيل المنشن)$",
"^(تفعيل التحقق)$",
"^(تفعيل البوت خدمي)$",
"^(تعطيل البوت خدمي)$",
"^(تفعيل التواصل)$",
"^(تعطيل التواصل)$",
"^(قفل الكل)$",
"^(فتح الكل)$",
"^(قفل الوسائط)$",
"^(فتح الوسائط)$",
"^(منع)$",
"^(البايو)$",
"^(بايو)$",
"^(صلاحياتي)$",
"^(صلاحياته)$",
"^(نسبه رجوله)$",
"^(صلاحياته) (@[%a%d_]+)$",
},
iBoss = iBoss,
dBoss = dBoss,
} 
