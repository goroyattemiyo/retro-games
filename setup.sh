#!/bin/bash
# =============================================================
#  RETRO GAME CENTER - Project Setup Script
#  使い方: bash setup.sh
# =============================================================
set -e
GREEN='\033[0;32m'; AMBER='\033[0;33m'; DIM='\033[2m'; NC='\033[0m'

echo ""
echo -e "${GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
echo -e "${GREEN}  RETRO GAME CENTER - PROJECT SETUP       ${NC}"
echo -e "${GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
echo ""

# --- ディレクトリ ---
echo -e "${AMBER}[1/4] Creating directories...${NC}"
mkdir -p sokoban daisenryaku nobunaga blackonyx portopia xanadu
for d in sokoban daisenryaku nobunaga blackonyx portopia xanadu; do
  echo -e "${DIM}  ✓ ${d}/${NC}"
done

# --- README ---
echo -e "${AMBER}[2/4] Writing README.md...${NC}"
cat > README.md << 'EOF'
# レトロゲームセンター 🖥️

PC-9801時代のゲームをブラウザで再現するプロジェクト。
PyScript + GitHub Pages で動作します。

## 🎮 タイトル一覧

| タイトル | ジャンル | 状態 |
|---|---|---|
| 倉庫番 | パズル | ✅ READY |
| 大戦略 | ウォーSLG | 🔧 WIP |
| 信長の野望 | 歴史SLG | 🔧 WIP |
| ブラックオニキス | ダンジョンRPG | 📋 SOON |
| ポートピア | アドベンチャー | 📋 SOON |
| ザナドゥ | アクションRPG | 📋 SOON |

## 🚀 GitHub Pages 公開

Settings → Pages → Branch: main → / (root) → Save
EOF
echo -e "${DIM}  ✓ README.md${NC}"

# --- index.html ---
echo -e "${AMBER}[3/4] Writing index.html (launcher)...${NC}"
cat > index.html << 'HTML'
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>RETRO GAME CENTER</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=DotGothic16&display=swap" rel="stylesheet">
  <style>
    :root{--green:#00ff41;--green-dim:#00aa2a;--green-dark:#003f0f;--green-faint:#001a06;--amber:#ffb300;--bg:#000d02;--sl:rgba(0,255,65,.025);}
    *{margin:0;padding:0;box-sizing:border-box;}
    body{background:var(--bg);color:var(--green);font-family:'Share Tech Mono',monospace;min-height:100vh;display:flex;flex-direction:column;align-items:center;padding:20px 10px 40px;overflow-x:hidden;}
    body::before{content:'';position:fixed;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 2px,var(--sl) 2px,var(--sl) 4px);pointer-events:none;z-index:200;}
    body::after{content:'';position:fixed;inset:0;background:radial-gradient(ellipse at center,transparent 55%,rgba(0,0,0,.85) 100%);pointer-events:none;z-index:199;}
    #header{width:100%;max-width:920px;border:1px solid var(--green-dark);background:var(--green-faint);margin-bottom:24px;}
    #tb{background:var(--green-dark);border-bottom:1px solid var(--green-dim);padding:3px 12px;display:flex;justify-content:space-between;font-size:11px;color:var(--green-dim);letter-spacing:2px;}
    #mt{padding:20px;text-align:center;}
    #mt h1{font-family:'DotGothic16',monospace;font-size:clamp(18px,5vw,36px);text-shadow:0 0 12px var(--green),0 0 30px rgba(0,255,65,.2);letter-spacing:6px;}
    #mt .eng{font-size:11px;color:var(--green-dim);letter-spacing:8px;margin-top:4px;}
    .si{display:flex;justify-content:center;gap:24px;flex-wrap:wrap;margin-top:12px;font-size:11px;color:var(--green-dim);border-top:1px solid var(--green-dark);padding-top:10px;}
    .si span{color:var(--green);}
    #grid{width:100%;max-width:920px;display:grid;grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:16px;}
    .card{border:1px solid var(--green-dark);background:var(--green-faint);cursor:pointer;text-decoration:none;color:inherit;display:block;transition:border-color .1s,box-shadow .1s;position:relative;overflow:hidden;}
    .card:hover{border-color:var(--green-dim);box-shadow:0 0 18px rgba(0,255,65,.15);}
    .card:hover .prev{filter:brightness(1.3);}
    .card:hover .arrow{opacity:1;transform:translateX(0);}
    .card.wip{pointer-events:none;opacity:.45;}
    .prev{width:100%;height:155px;background:#000;border-bottom:1px solid var(--green-dark);display:flex;align-items:center;justify-content:center;overflow:hidden;transition:filter .15s;position:relative;}
    .prev pre{font-family:'Share Tech Mono',monospace;font-size:clamp(10px,2vw,12px);line-height:1.38;pointer-events:none;white-space:pre;}
    .p0 pre{color:#ffb300;} .p1 pre{color:#00e5ff;} .p2 pre{color:#ff6b35;}
    .p3 pre{color:#b388ff;} .p4 pre{color:#a5d6a7;} .p5 pre{color:#ff80ab;}
    .noise{position:absolute;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 3px,rgba(0,0,0,.15) 3px,rgba(0,0,0,.15) 4px);pointer-events:none;}
    .badge{position:absolute;top:8px;right:8px;font-size:9px;padding:2px 6px;border:1px solid;letter-spacing:1px;}
    .b-ready{color:var(--green);border-color:var(--green-dim);background:rgba(0,255,65,.08);}
    .b-wip{color:var(--amber);border-color:#664800;background:rgba(255,179,0,.08);}
    .b-soon{color:var(--green-dim);border-color:var(--green-dark);background:transparent;}
    .cb{padding:12px 14px;}
    .ct{display:flex;justify-content:space-between;align-items:baseline;margin-bottom:5px;}
    .cn{font-family:'DotGothic16',monospace;font-size:16px;color:var(--green);text-shadow:0 0 6px rgba(0,255,65,.3);}
    .cy{font-size:10px;color:var(--green-dark);}
    .cg{font-size:10px;color:var(--green-dim);letter-spacing:2px;margin-bottom:6px;}
    .cd{font-size:11px;color:var(--green-dim);line-height:1.6;}
    .cf{margin-top:10px;border-top:1px solid var(--green-dark);padding-top:8px;display:flex;justify-content:space-between;font-size:10px;color:var(--green-dark);}
    .arrow{color:var(--green);font-size:12px;opacity:0;transform:translateX(-6px);transition:all .15s;}
    #footer{width:100%;max-width:920px;margin-top:24px;border-top:1px solid var(--green-dark);padding-top:12px;display:flex;justify-content:space-between;flex-wrap:wrap;gap:8px;font-size:10px;color:var(--green-dark);}
    .blink{animation:blink 1s step-end infinite;} @keyframes blink{50%{opacity:0;}}
    #clk{color:var(--green-dim);}
  </style>
</head>
<body>
<div id="header">
  <div id="tb"><span>GAME_CENTER.EXE &nbsp; ver 1.00</span><span class="blink">█</span><span id="clk">--:--:--</span></div>
  <div id="mt">
    <h1>レトロゲームセンター</h1>
    <div class="eng">RETRO GAME CENTER</div>
    <div class="si"><div>SYSTEM: <span>PC-9801</span></div><div>MEDIA: <span>5"2HD FD</span></div><div>MEMORY: <span>640KB</span></div><div>TITLES: <span>6</span></div></div>
  </div>
</div>
<div id="grid">
  <a class="card" href="sokoban/index.html">
    <div class="prev p0"><pre>########
# . # .#
#□☺×   #
#  □   #
##.#####</pre><div class="noise"></div><div class="badge b-ready">READY</div></div>
    <div class="cb"><div class="ct"><div class="cn">倉庫番</div><div class="cy">1982</div></div><div class="cg">PUZZLE / SOKOBAN</div><div class="cd">箱を所定の位置に押して運ぶパズルゲーム。思考力が試される全5ステージ。</div><div class="cf"><span>PyScript</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
  <a class="card wip" href="daisenryaku/index.html">
    <div class="prev p1"><pre>┌──┬──┬──┬──┐
│山│  │敵│  │
├──┼──┼──┼──┤
│  │自│  │城│
├──┼──┼──┼──┤
│川│  │  │  │
└──┴──┴──┴──┘</pre><div class="noise"></div><div class="badge b-wip">WIP</div></div>
    <div class="cb"><div class="ct"><div class="cn">大戦略</div><div class="cy">1985</div></div><div class="cg">WAR STRATEGY / SIMULATION</div><div class="cd">ターン制の戦略シミュレーション。ヘックスマップで兵力を指揮して敵を撃破せよ。</div><div class="cf"><span>Coming soon</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
  <a class="card wip" href="nobunaga/index.html">
    <div class="prev p2"><pre>天正十年  六月
武将一覧
─────────────
織田信長 [尾張]
武田信玄 [甲斐]
上杉謙信 [越後]</pre><div class="noise"></div><div class="badge b-wip">WIP</div></div>
    <div class="cb"><div class="ct"><div class="cn">信長の野望</div><div class="cy">1983</div></div><div class="cg">HISTORY / STRATEGY</div><div class="cd">戦国時代の大名となり天下統一を目指す歴史シミュレーション。内政・外交・戦争。</div><div class="cf"><span>Coming soon</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
  <a class="card wip" href="blackonyx/index.html">
    <div class="prev p3"><pre>B2F  ▓▓▓▓▓▓▓▓
     ▓      ▓
     ▓  !!  ▓
     ▓      ▓
     ▓▓▓▓.▓▓▓
HP:45  MP:12</pre><div class="noise"></div><div class="badge b-soon">SOON</div></div>
    <div class="cb"><div class="ct"><div class="cn">ブラックオニキス</div><div class="cy">1984</div></div><div class="cg">RPG / DUNGEON</div><div class="cd">迷宮を探索するダンジョンRPGの草分け。パーティを組んで深層を目指せ。</div><div class="cf"><span>Coming soon</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
  <a class="card wip" href="portopia/index.html">
    <div class="prev p4"><pre>
＞ 部屋を 調べる

  古い机がある。
  引き出しに
  何かがある…
＞_</pre><div class="noise"></div><div class="badge b-soon">SOON</div></div>
    <div class="cb"><div class="ct"><div class="cn">ポートピア</div><div class="cy">1983</div></div><div class="cg">ADVENTURE / MYSTERY</div><div class="cd">堀井雄二作のコマンド入力型ADV。神戸を舞台に連続殺人事件を解け。</div><div class="cf"><span>Coming soon</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
  <a class="card wip" href="xanadu/index.html">
    <div class="prev p5"><pre>♠ XANADU  Lv.4
━━━━━━━━━━━━
HP ████░░  62
MP ██░░░░  28
EXP ──── 4820
[ドラゴンスレイヤー]</pre><div class="noise"></div><div class="badge b-soon">SOON</div></div>
    <div class="cb"><div class="ct"><div class="cn">ザナドゥ</div><div class="cy">1985</div></div><div class="cg">ACTION RPG / FALCOM</div><div class="cd">日本ファルコムのアクションRPG。ドラゴンスレイヤーII。複雑なレベルシステム。</div><div class="cf"><span>Coming soon</span><span class="arrow">▶ PLAY</span></div></div>
  </a>
</div>
<div id="footer"><span>© RETRO GAME CENTER &nbsp;|&nbsp; GitHub Pages</span><span>PyScript 2024 &nbsp;|&nbsp; 5"2HD COMPATIBLE</span><span class="blink">■</span></div>
<script>
function tick(){const n=new Date();document.getElementById('clk').textContent=String(n.getHours()).padStart(2,'0')+':'+String(n.getMinutes()).padStart(2,'0')+':'+String(n.getSeconds()).padStart(2,'0');}
setInterval(tick,1000);tick();
</script>
</body>
</html>
HTML
echo -e "${DIM}  ✓ index.html${NC}"

# --- sokoban/index.html ---
cat > sokoban/index.html << 'HTML'
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>倉庫番 - SOKOBAN</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=DotGothic16&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://pyscript.net/releases/2024.1.1/core.css">
  <script type="module" src="https://pyscript.net/releases/2024.1.1/core.js"></script>
  <style>
    :root{--green:#00ff41;--green-dim:#00aa2a;--green-dark:#003f0f;--green-faint:#001a06;--amber:#ffb300;--bg:#000d02;--sl:rgba(0,255,65,.03);}
    *{margin:0;padding:0;box-sizing:border-box;}
    body{background:var(--bg);color:var(--green);font-family:'Share Tech Mono',monospace;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;overflow:hidden;}
    body::before{content:'';position:fixed;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 2px,var(--sl) 2px,var(--sl) 4px);pointer-events:none;z-index:100;}
    body::after{content:'';position:fixed;inset:0;background:radial-gradient(ellipse at center,transparent 60%,rgba(0,0,0,.8) 100%);pointer-events:none;z-index:99;}
    #terminal{width:min(700px,98vw);border:2px solid var(--green-dim);box-shadow:0 0 30px rgba(0,255,65,.2);background:var(--bg);}
    #tb{background:var(--green-dark);border-bottom:1px solid var(--green-dim);padding:4px 12px;display:flex;justify-content:space-between;align-items:center;font-size:11px;color:var(--green-dim);letter-spacing:2px;}
    #tb a{color:var(--green-dim);text-decoration:none;} #tb a:hover{color:var(--green);}
    .blink{animation:blink 1s step-end infinite;} @keyframes blink{50%{opacity:0;}}
    #screen{padding:20px;}
    #hd{text-align:center;margin-bottom:16px;border-bottom:1px solid var(--green-dark);padding-bottom:12px;}
    #hd h1{font-family:'DotGothic16',monospace;font-size:28px;text-shadow:0 0 10px var(--green);letter-spacing:8px;}
    #hd .sub{font-size:11px;color:var(--green-dim);letter-spacing:4px;margin-top:4px;}
    #ib{display:flex;justify-content:space-between;flex-wrap:wrap;gap:6px;margin-bottom:12px;font-size:12px;color:var(--green-dim);border:1px solid var(--green-dark);padding:4px 10px;background:var(--green-faint);}
    #ib span{color:var(--green);}
    #ga{font-family:'Share Tech Mono',monospace;font-size:clamp(16px,3.5vw,22px);line-height:1.4;text-align:center;letter-spacing:.1em;min-height:200px;display:flex;align-items:center;justify-content:center;}
    #ga pre{display:inline-block;text-align:left;}
    .cell-wall{color:var(--green-dim);}.cell-floor{color:var(--green-dark);}
    .cell-box{color:var(--amber);text-shadow:0 0 6px var(--amber);}
    .cell-goal{color:#ff6b6b;}.cell-done{color:#00ffff;text-shadow:0 0 6px #00ffff;}
    .cell-player{color:var(--green);text-shadow:0 0 8px var(--green);}
    .cell-player-goal{color:#ff6b6b;text-shadow:0 0 8px #ff6b6b;}
    #msg{text-align:center;margin-top:14px;font-size:13px;min-height:20px;color:var(--amber);letter-spacing:2px;}
    #ctrl{margin-top:14px;border-top:1px solid var(--green-dark);padding-top:10px;font-size:11px;color:var(--green-dim);display:flex;justify-content:center;gap:20px;flex-wrap:wrap;}
    #ctrl kbd{background:var(--green-dark);border:1px solid var(--green-dim);padding:1px 5px;color:var(--green);font-family:inherit;}
    .sbtn{background:var(--green-dark);border:1px solid var(--green-dim);color:var(--green);font-family:'Share Tech Mono',monospace;font-size:12px;padding:3px 10px;cursor:pointer;letter-spacing:1px;transition:all .1s;}
    .sbtn:hover{background:var(--green-dim);color:var(--bg);}
    #cs{text-align:center;padding:40px 20px;}
    #cs .big{font-family:'DotGothic16',monospace;font-size:22px;color:#00ffff;text-shadow:0 0 12px #00ffff;animation:pulse 1s ease-in-out infinite;letter-spacing:4px;}
    @keyframes pulse{0%,100%{opacity:1;}50%{opacity:.6;}}
    #cs p{margin-top:12px;color:var(--green-dim);font-size:12px;}
    #ld{text-align:center;padding:60px;color:var(--green-dim);font-size:13px;letter-spacing:3px;}
  </style>
</head>
<body>
<div id="terminal">
  <div id="tb">
    <span><a href="../index.html">◀ MENU</a> &nbsp;|&nbsp; SOKOBAN.EXE ver 1.00</span>
    <span class="blink">■</span>
    <span>PC-9801</span>
  </div>
  <div id="screen">
    <div id="hd"><h1>倉庫番</h1><div class="sub">SOKOBAN &mdash; WAREHOUSE KEEPER</div></div>
    <div id="ib">
      <div>STAGE: <span id="sn">1</span></div>
      <div>MOVES: <span id="mc">0</span></div>
      <div>BOXES: <span id="bc">0/0</span></div>
      <div>
        <button class="sbtn" id="bp">◀ PREV</button>
        <button class="sbtn" id="br">RESET</button>
        <button class="sbtn" id="bn">NEXT ▶</button>
      </div>
    </div>
    <div id="ga"><div id="ld">LOADING</div></div>
    <div id="msg"></div>
    <div id="ctrl">
      <span><kbd>↑↓←→</kbd> 移動</span>
      <span><kbd>R</kbd> やり直し</span>
      <span><kbd>N</kbd> 次</span>
      <span><kbd>P</kbd> 前</span>
    </div>
  </div>
</div>
<script type="py">
from pyscript import document
S=[
  {"name":"STAGE 1","map":["########","#  . # #","# $@.  #","#   $  #","##.#####","#      #","# $  . #","########"]},
  {"name":"STAGE 2","map":["  #####","  #   #","  #$  #","###  $##","#  $ . #","# . #. #","#   @  #","########"]},
  {"name":"STAGE 3","map":["########","#      #","# .$@$.#","#  ...  #","# .$.$. #","#      #","########"]},
  {"name":"STAGE 4","map":["   ##### ","   #   # ","   # $@# "," ### $## "," #.$ .#  "," # . ##  "," #.  #   "," ######  "]},
  {"name":"STAGE 5","map":["#########","# . # . #","# $   $ #","#   @   #","# $   $ #","# . # . #","#########"]},
]
W='#';F=' ';B='$';G='.';D='*';P='@';PG='+'
DI={W:('▓','cell-wall'),F:('·','cell-floor'),B:('□','cell-box'),G:('×','cell-goal'),D:('■','cell-done'),P:('☺','cell-player'),PG:('☺','cell-player-goal')}
st={'i':0,'g':[],'p':(0,0),'m':0,'c':False}
def ps(i):
  r=[list(x) for x in S[i]['map']];p=(0,0)
  for y,row in enumerate(r):
    for x,c in enumerate(row):
      if c in(P,PG):p=(y,x)
  return r,p
def ls(i):
  st['i']=i;st['g'],st['p']=ps(i);st['m']=0;st['c']=False;rd()
def cb(g):
  pl=sum(row.count(D) for row in g);tot=pl+sum(row.count(B) for row in g);return pl,tot
def ic(g): return not any(B in row for row in g)
def mv(dr,dc):
  if st['c']:return
  r,c=st['p'];nr,nc=r+dr,c+dc;g=st['g']
  if nr<0 or nr>=len(g) or nc<0 or nc>=len(g[nr]):return
  t=g[nr][nc]
  if t==W:return
  if t in(B,D):
    br,bc=nr+dr,nc+dc
    if br<0 or br>=len(g) or bc<0 or bc>=len(g[br]):return
    bv=g[br][bc]
    if bv in(W,B,D):return
    g[nr][nc]=G if t==D else F;g[br][bc]=D if bv==G else B
  cur=g[r][c];g[r][c]=G if cur==PG else F
  g[nr][nc]=PG if g[nr][nc]==G else P
  st['p']=(nr,nc);st['m']+=1
  if ic(g):st['c']=True
  rd()
def rd():
  g=st['g'];pl,tot=cb(g)
  document.getElementById('sn').textContent=str(st['i']+1)
  document.getElementById('mc').textContent=str(st['m'])
  document.getElementById('bc').textContent=f"{pl}/{tot}"
  ga=document.getElementById('ga');mg=document.getElementById('msg')
  if st['c']:
    ga.innerHTML='<div id="cs"><div class="big">*** STAGE CLEAR! ***</div><p>MOVES: '+str(st['m'])+' | PRESS N FOR NEXT</p></div>';mg.textContent='';return
  h='<pre>'
  for row in g:
    for ch in row:
      if ch==' ':ch=F
      s,cl=DI.get(ch,(ch,'cell-floor'));h+=f'<span class="{cl}">{s}</span>'
    h+='\n'
  h+='</pre>';ga.innerHTML=h;mg.textContent=S[st['i']]['name']
def ok(e):
  k=e.key
  if k=='ArrowUp' or k=='w':mv(-1,0)
  elif k=='ArrowDown' or k=='s':mv(1,0)
  elif k=='ArrowLeft' or k=='a':mv(0,-1)
  elif k=='ArrowRight' or k=='d':mv(0,1)
  elif k in('r','R'):ls(st['i'])
  elif k in('n','N'):
    if st['i']<len(S)-1:ls(st['i']+1)
  elif k in('p','P'):
    if st['i']>0:ls(st['i']-1)
  e.preventDefault()
document.addEventListener('keydown',ok)
def on_r(e):ls(st['i'])
def on_n(e):
  if st['i']<len(S)-1:ls(st['i']+1)
def on_p(e):
  if st['i']>0:ls(st['i']-1)
document.getElementById('br').addEventListener('click',on_r)
document.getElementById('bn').addEventListener('click',on_n)
document.getElementById('bp').addEventListener('click',on_p)
ls(0)
</script>
</body>
</html>
HTML
echo -e "${DIM}  ✓ sokoban/index.html${NC}"

# --- プレースホルダー生成関数 ---
echo -e "${AMBER}[4/4] Writing placeholder pages...${NC}"
make_ph() {
  local DIR=$1 TJ=$2 TE=$3 COL=$4 GE=$5
  cat > "$DIR/index.html" << PLACEHOLDER
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>${TJ} - RETRO GAME CENTER</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=DotGothic16&display=swap" rel="stylesheet">
  <style>
    :root{--c:${COL};--bg:#000d02;--gd:#003f0f;--gm:#00aa2a;--sl:rgba(0,255,65,.025);}
    *{margin:0;padding:0;box-sizing:border-box;}
    body{background:var(--bg);color:var(--c);font-family:'Share Tech Mono',monospace;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;overflow:hidden;}
    body::before{content:'';position:fixed;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 2px,var(--sl) 2px,var(--sl) 4px);pointer-events:none;z-index:100;}
    body::after{content:'';position:fixed;inset:0;background:radial-gradient(ellipse at center,transparent 60%,rgba(0,0,0,.8) 100%);pointer-events:none;z-index:99;}
    #box{width:min(560px,95vw);border:2px solid var(--gm);background:#000;}
    #tb{background:var(--gd);border-bottom:1px solid var(--gm);padding:4px 12px;display:flex;justify-content:space-between;font-size:11px;color:var(--gm);letter-spacing:2px;}
    #tb a{color:var(--gm);text-decoration:none;} #tb a:hover{color:#00ff41;}
    #bd{padding:40px 30px;text-align:center;}
    h1{font-family:'DotGothic16',monospace;font-size:clamp(24px,6vw,40px);color:var(--c);text-shadow:0 0 12px var(--c);letter-spacing:6px;margin-bottom:8px;}
    .ge{font-size:11px;color:var(--gm);letter-spacing:4px;margin-bottom:32px;}
    .wip{border:1px solid var(--c);padding:16px 32px;display:inline-block;margin-bottom:32px;opacity:.6;}
    .wip span{font-size:18px;color:var(--c);letter-spacing:4px;}
    .msg{font-size:12px;color:var(--gm);line-height:1.9;}
    a.back{display:inline-block;margin-top:24px;color:var(--gm);font-size:12px;text-decoration:none;border:1px solid var(--gd);padding:6px 16px;letter-spacing:2px;}
    a.back:hover{color:#00ff41;border-color:var(--gm);}
    .blink{animation:blink 1s step-end infinite;} @keyframes blink{50%{opacity:0;}}
  </style>
</head>
<body>
<div id="box">
  <div id="tb"><span><a href="../index.html">◀ MENU</a> &nbsp;|&nbsp; ${TE}.EXE</span><span class="blink">■</span><span>PC-9801</span></div>
  <div id="bd">
    <h1>${TJ}</h1>
    <div class="ge">${GE}</div>
    <div class="wip"><span>-- UNDER CONSTRUCTION --</span></div>
    <div class="msg">このゲームは現在開発中です。<br>しばらくお待ちください。<br><br><span class="blink">█</span></div>
    <a class="back" href="../index.html">◀ MENU に戻る</a>
  </div>
</div>
</body>
</html>
PLACEHOLDER
  echo -e "${DIM}  ✓ ${DIR}/index.html${NC}"
}

make_ph daisenryaku "大戦略"         "DAISENRYAKU" "#00e5ff" "WAR STRATEGY / SIMULATION"
make_ph nobunaga    "信長の野望"      "NOBUNAGA"    "#ff6b35" "HISTORY / STRATEGY"
make_ph blackonyx   "ブラックオニキス" "BLACKONYX"  "#b388ff" "RPG / DUNGEON"
make_ph portopia    "ポートピア"      "PORTOPIA"    "#a5d6a7" "ADVENTURE / MYSTERY"
make_ph xanadu      "ザナドゥ"        "XANADU"      "#ff80ab" "ACTION RPG / FALCOM"

# --- 完了 ---
echo ""
echo -e "${GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
echo -e "${GREEN}  SETUP COMPLETE!${NC}"
echo -e "${GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
echo ""
echo -e "  📁 Generated:"
for f in index.html README.md sokoban/index.html daisenryaku/index.html nobunaga/index.html blackonyx/index.html portopia/index.html xanadu/index.html; do
  echo -e "${DIM}     ${f}${NC}"
done
echo ""
echo -e "  🚀 Push to GitHub:"
echo -e "${AMBER}     git add .${NC}"
echo -e "${AMBER}     git commit -m 'init: retro game center'${NC}"
echo -e "${AMBER}     git push${NC}"
echo ""
echo -e "  🌐 Enable GitHub Pages:"
echo -e "${DIM}     Settings → Pages → Branch: main → / (root) → Save${NC}"
echo ""