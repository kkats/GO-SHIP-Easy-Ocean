function zinterp = vinterp_rr68(p, z, grid)
%
% vertical interpolation by Reiniger and Ross (1968)
%
% "A method of interpolation with application to oceanographic data"
% Deep-Sea Research, 1968, 15, 188--193
%
zinterp = NaN(length(grid),1);
grid = grid(:); % expecting column

ig = find(~isnan(p) & ~isnan(z));
if length(ig) < 4 % at least four bottles
   return;
end
p1 = p(ig); z1 = z(ig);

% often multiple data exist at one depth
[p2, dummy1, idx1] = unique(p1);
z2 = NaN(size(p2));
for i = 1:length(p2)
    is = find(idx1 == i);
    z2(i) = nanmean(z1(is));
end

% counter i is for p,
%         j is for grid
jshallow = find(p2(1) <= grid & grid <= p2(2));
jcentral = find(p2(2) < grid & grid <= p2(end-1));
jdeep = find(p2(end-1) < grid & grid <= p2(end));

j3 = ceil(interp1(p2, [1:length(p2)], grid(jcentral)));
j4 = j3 + 1;
j2 = floor(interp1(p2, [1:length(p2)], grid(jcentral)));
j1 = j2 - 1;

%%%
%%% central
%%%
z12 = z2(j1) + (z2(j2) - z2(j1)) .* (grid(jcentral) - grid(j1)) ./ (p2(j2) - p2(j1));
z23 = z2(j2) + (z2(j3) - z2(j2)) .* (grid(jcentral) - grid(j2)) ./ (p2(j3) - p2(j2));
z34 = z2(j3) + (z2(j4) - z2(j3)) .* (grid(jcentral) - grid(j3)) ./ (p2(j4) - p2(j3));

% reference curve Eq.(1)
m = 1.7;
zref_nume = (abs(z12 - z23).^m) .* z23 + (abs(z23 - z34).^m) .* z12;
zref_deno = (abs(z12 - z23).^m) + abs(z23 - z34).^m;
zref = 0.5 * (z23 + zref_nume ./ zref_deno);

% Eq.(3c)
gamma1_23 = (grid(jcentral) - p2(j2)) .* (grid(jcentral) - p2(j3)) ...
            ./ ((p2(j1) - p2(j2)) .* (p2(j1) - p2(j3)));
gamma2_31 = (grid(jcentral) - p2(j3)) .* (grid(jcentral) - p2(j1)) ...
            ./ ((p2(j2) - p2(j3)) .* (p2(j2) - p2(j1)));
gamma3_12 = (grid(jcentral) - p2(j1)) .* (grid(jcentral) - p2(j2)) ...
            ./ ((p2(j3) - p2(j1)) .* (p2(j3) - p2(j2)));
gamma2_34 = (grid(jcentral) - p2(j3)) .* (grid(jcentral) - p2(j4)) ...
            ./ ((p2(j2) - p2(j3)) .* (p2(j2) - p2(j4)));
gamma3_42 = (grid(jcentral) - p2(j4)) .* (grid(jcentral) - p2(j2)) ...
            ./ ((p2(j3) - p2(j4)) .* (p2(j3) - p2(j2)));
gamma4_23 = (grid(jcentral) - p2(j2)) .* (grid(jcentral) - p2(j3)) ...
            ./ ((p2(j4) - p2(j2)) .* (p2(j4) - p2(j3)));
% Eq.(3b)
zp1 = gamma1_23 .* z2(j1) + gamma2_31 .* z2(j2) + gamma3_12 .* z2(j3);
zp2 = gamma2_34 .* z2(j2) + gamma3_42 .* z2(j3) + gamma4_23 .* z2(j4);

% Eq.(3)
zinterp(jcentral) = (abs(zref - zp1) .* zp2 + abs(zref - zp2) .* zp1) ...
                  ./ (abs(zref - zp1) + abs(zref - zp2));

%%% shallow
j1 = floor(interp1(p2, [1:length(p2)], grid(jshallow)));
j2 = ceil(interp1(p2, [1:length(p2)], grid(jshallow)));
z12 = z2(j1) + (z2(j2) - z2(j1)) .* (grid(jshallow) - grid(j1)) ./ (p2(j2) - p2(j1));
j3 = j2 + 1;
j4 = j3 + 1;
z13 = z2(j1) + (z2(j3) - z2(j1)) .* (grid(jshallow) - grid(j1)) ./ (p2(j3) - p2(j1));
z23 = z2(j2) + (z2(j3) - z2(j2)) .* (grid(jshallow) - grid(j2)) ./ (p2(j3) - p2(j2));
z34 = z2(j3) + (z2(j4) - z2(j3)) .* (grid(jshallow) - grid(j3)) ./ (p2(j4) - p2(j2));
zref_nume = abs(z12 - z23).^m .* z34 + abs(z12- z13).^m .* z23;
zref_deno = abs(z12 - z23).^m + abs(z12 - z13).^m;
zref = 0.5 * (z12 + zref_nume ./ zref_deno);
gamma1_23 = (grid(jshallow) - p2(j2)) .* (grid(jshallow) - p2(j3)) ...
            ./ ((p2(j1) - p2(j2)) .* (p2(j1) - p2(j3)));
gamma2_31 = (grid(jshallow) - p2(j3)) .* (grid(jshallow) - p2(j1)) ...
            ./ ((p2(j2) - p2(j3)) .* (p2(j2) - p2(j1)));
gamma3_12 = (grid(jshallow) - p2(j1)) .* (grid(jshallow) - p2(j2)) ...
            ./ ((p2(j3) - p2(j1)) .* (p2(j3) - p2(j2)));
gamma1_24 = (grid(jshallow) - p2(j2)) .* (grid(jshallow) - p2(j4)) ...
            ./ ((p2(j1) - p2(j2)) .* (p2(j1) - p2(j4)));
gamma2_41 = (grid(jshallow) - p2(j4)) .* (grid(jshallow) - p2(j1)) ...
            ./ ((p2(j2) - p2(j4)) .* (p2(j2) - p2(j1)));
gamma4_12 = (grid(jshallow) - p2(j1)) .* (grid(jshallow) - p2(j2)) ...
            ./ ((p2(j4) - p2(j1)) .* (p2(j4) - p2(j2)));
zp1 = gamma1_23 .* z2(j1) + gamma2_31 .* z2(j2) + gamma3_12 .* z2(j3);
zp2 = gamma1_24 .* z2(j1) + gamma2_41 .* z2(j2) + gamma4_12 .* z2(j4);
zinterp(jshallow) = (abs(zref - zp1) .* zp2 + abs(zref - zp2) .* zp1) ...
                  ./ (abs(zref - zp1) + abs(zref - zp2));
%%% deep
j1 = ceil(interp1(p2, [1:length(p2)], grid(jdeep)));
j2 = floor(interp1(p2, [1:length(p2)], grid(jdeep)));
z22 = z2(j1) + (z2(j2) - z2(j1)) .* (grid(jdeep) - grid(j1)) ./ (p2(j2) - p2(j1));
j3 = j2 - 1;
j4 = j3 - 1;
z23 = z2(j1) + (z2(j3) - z2(j1)) .* (grid(jdeep) - grid(j1)) ./ (p2(j3) - p2(j1));
z23 = z2(j2) + (z2(j3) - z2(j2)) .* (grid(jdeep) - grid(j2)) ./ (p2(j3) - p2(j2));
z34 = z2(j3) + (z2(j4) - z2(j3)) .* (grid(jdeep) - grid(j3)) ./ (p2(j4) - p2(j2));
zref_nume = abs(z22 - z23).^m .* z34 + abs(z22- z23).^m .* z23;
zref_deno = abs(z22 - z23).^m + abs(z22 - z23).^m;
zref = 0.5 * (z22 + zref_nume ./ zref_deno);
gamma1_23 = (grid(jdeep) - p2(j2)) .* (grid(jdeep) - p2(j3)) ...
            ./ ((p2(j1) - p2(j2)) .* (p2(j1) - p2(j3)));
gamma2_31 = (grid(jdeep) - p2(j3)) .* (grid(jdeep) - p2(j1)) ...
            ./ ((p2(j2) - p2(j3)) .* (p2(j2) - p2(j1)));
gamma3_12 = (grid(jdeep) - p2(j1)) .* (grid(jdeep) - p2(j2)) ...
            ./ ((p2(j3) - p2(j1)) .* (p2(j3) - p2(j2)));
gamma1_24 = (grid(jdeep) - p2(j2)) .* (grid(jdeep) - p2(j4)) ...
            ./ ((p2(j1) - p2(j2)) .* (p2(j1) - p2(j4)));
gamma2_41 = (grid(jdeep) - p2(j4)) .* (grid(jdeep) - p2(j1)) ...
            ./ ((p2(j2) - p2(j4)) .* (p2(j2) - p2(j1)));
gamma4_12 = (grid(jdeep) - p2(j1)) .* (grid(jdeep) - p2(j2)) ...
            ./ ((p2(j4) - p2(j1)) .* (p2(j4) - p2(j2)));
zp1 = gamma1_23 .* z2(j1) + gamma2_31 .* z2(j2) + gamma3_12 .* z2(j3);
zp2 = gamma1_24 .* z2(j1) + gamma2_41 .* z2(j2) + gamma4_12 .* z2(j4);
zinterp(jdeep) = (abs(zref - zp1) .* zp2 + abs(zref - zp2) .* zp1) ...
                  ./ (abs(zref - zp1) + abs(zref - zp2));
end % function
function y = nanmean(x)
    ig = find(~isnan(x));
    if isempty(ig)
        y = NaN;
    else
        y = mean(x(ig));
    end
end
