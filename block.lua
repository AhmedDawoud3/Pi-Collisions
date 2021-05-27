Block = Class {}

function Block:init(x, w, m, v)
    self.x = x;
    self.y = love.graphics.getHeight() - w;
    self.w = w;
    self.v = v;
    self.m = m;
end

function Block:HitWall()
    return self.x <= 0
end

function Block:Reverse()
    self.v = self.v * -1
end

function Block:Collides(other)
    return not ((self.x + self.w < other.x) or self.x > other.x + other.w)
end

function Block:Bounce(other)
    local sumM = self.m + other.m
    local newV = ((self.m - other.m) / sumM) * self.v
    local newV = newV + ((2 * other.m) / sumM) * other.v
    return newV
end

function Block:Update()
    self.x = self.x + self.v
end

function Block:Render()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.w)
end
