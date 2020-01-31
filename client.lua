local sx,sy = guiGetScreenSize()
--resolution of developer/sx or sy
local ratioW,ratioH = 1920/sx, 1080/sy
--we using math.floor on any sizes,coordinates to avoid incorrect rendering like a white lines or blurring 
function getX(size) return math.floor(size/ratioW) end
function getY(size) return math.floor(size/ratioH) end
function getSize(size) return math.floor((getX(size)+getY(size))/2) end

local text = "MTA ADAPTIVE DX INTERFACE"

--calculate width and height in adaptive mode
--also we can use here fontWidth and fontHeight
local width,height = getSize(280),getSize(35)
--coords of our element start in adaptive mode
local x,y = getX(1920),getY(1080)

--its better to change text size with createDXfont, default text scaling can blur your text
local font = dxCreateFont("font.ttf",getSize(15),false,"cleartype")
--here is we get our text size
local fontWidth,fontHeight = dxGetTextWidth(text,1,font),dxGetFontHeight(1,font)

--here is for example we creating font without adaptation
local fontWithoutAdaptation = dxCreateFont("font.ttf",15,false,"cleartype")
local fontWithoutAdaptationWidth,fontWithoutAdaptationHeight = dxGetTextWidth(text,1,fontWithoutAdaptation),dxGetFontHeight(1,fontWithoutAdaptation)

addEventHandler("onClientRender", root,
    function()     
        --for example lets render it all in default way
        --ingame on smaller resolution we can see red elements, its how its would look like without adaptation
        dxDrawRectangle(x-280,y-35,280,35,tocolor(255,0,0,100))
        dxDrawText(text, x - fontWithoutAdaptationWidth, y-fontWithoutAdaptationHeight, fontWithoutAdaptationWidth, fontWithoutAdaptationHeight, tocolor(255, 20, 20, 150), 1.00,fontWithoutAdaptation)
        
        --render our elements with adaptation
        dxDrawRectangle(x-width,y-height,width,height)
        dxDrawText(text, x - fontWidth, y-fontHeight, fontWidth, fontHeight, tocolor(0, 0, 0, 255), 1.00,font)
end
)