import json

blocks = []

MIN_ID = 1
MAX_ID = 767

for i in range(MIN_ID, MAX_ID):
    blocks.append({
    "BlockID": i,
    "Name": str(i),
    "Speed": 1,
    "CollideType": 2,
    "TopTex": i,
    "BottomTex": i,
    "BlocksLight": True,
    "WalkSound": 0,
    "FullBright": False,
    "Shape": 16,
    "BlockDraw": 0,
    "FallBack": 1,
    "FogDensity": 0,
    "FogR": 0,
    "FogG": 0,
    "FogB": 0,
    "MinX": 0,
    "MinY": 0,
    "MinZ": 0,
    "MaxX": 16,
    "MaxY": 16,
    "MaxZ": 16,
    "LeftTex": i,
    "RightTex": i,
    "FrontTex": i,
    "BackTex": i,
    "InventoryOrder": 0
})

with open('blockdef.json', 'w') as f:
    json.dump(blocks, f)
