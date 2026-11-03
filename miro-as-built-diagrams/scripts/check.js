const fs=require("fs");
const s=fs.readFileSync(process.argv[2],"utf8");
const plain=(t)=>t.replace(/&lt;br\s*\/?&gt;|<br\s*\/?>/g,"\n").replace(/&lt;[^&]*&gt;|<[^>]+>/g,"");
const linesFor=(text,width,size)=>{const cpl=Math.max(8,Math.floor(width/(size*0.53)));return text.split("\n").map(p=>Math.max(1,Math.ceil(p.length/cpl))).reduce((a,b)=>a+b,0)};
const re=/<textArea\b([^>]*)>([\s\S]*?)<\/textArea>/g;let m,bad=0,n=0;
while((m=re.exec(s))){n++;const a=m[1];const g=k=>{const r=a.match(new RegExp(' '+k+'="([^"]*)"'));return r&&r[1]};
const w=+g("width"),h=+g("height"),fs_=+g("font-size");const exp=Math.ceil(linesFor(plain(m[2]),w,fs_)*fs_*1.42);
if(h>exp+4){bad++;console.log("OVER",g("y"),w,"h",h,"exp",exp,plain(m[2]).slice(0,60))}}
// shapes with content: check estimated text height vs box
const re2=/<rect\b([^>]*data-content="([^"]*)"[^>]*)\/>/g;
while((m=re2.exec(s))){const a=m[1];const g=k=>{const r=a.match(new RegExp(' '+k+'="([^"]*)"'));return r&&r[1]};const w=+g("width"),h=+g("height"),f=+(g("data-font-size")||14);const exp=Math.ceil(linesFor(plain(m[2].replace(/&lt;br&gt;/g,"\n")),w-40,f)*f*1.42)+20;if(exp>h)console.log("BOXTIGHT",g("y"),w,h,"needs",exp,plain(m[2]).slice(0,50))}
console.log("textAreas",n,"over",bad);
