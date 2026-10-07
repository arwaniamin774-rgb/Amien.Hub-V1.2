local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local char = LocalPlayer.Character

print("=== START DEBUG Amien.Hub ===")

-- 1. Cek isi karakter saat pegang telur
if char then
    print("--- Objek di dalam Character: ---")
    for _, child in ipairs(char:GetChildren()) do
        print("Child:", child.Name, "| Type:", child.ClassName)
    end

    print("--- Attribute Character: ---")
    for attr, val in pairs(char:GetAttributes()) do
        print("Attribute:", attr, "=", tostring(val))
    end)
else
    print("Character belum tersedia.")
end

-- 2. Cek nama Spawn / Safezone di Workspace
print("--- Objek potensial SafeZone di Workspace: ---")
for _, obj in ipairs(workspace:GetChildren()) do
    if obj:IsA("BasePart") or obj:IsA("Model") then
        local n = obj.Name:lower()
        if n:find("safe") or n:find("zone") or n:find("base") or n:find("spawn") or n:find("home") then
            print("Found SafeZone Candidate:", obj.Name, "| Type:", obj.ClassName)
        end
    end
end

print("=== END DEBUG Amien.Hub ===")
