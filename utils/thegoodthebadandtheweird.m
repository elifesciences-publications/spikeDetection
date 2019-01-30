function [good,weird,weirdbad,bad] = thegoodthebadandtheweird(x,y,xt,yt)

% The weird/borderline
weird = y > yt & x<xt & ...
    (x>quantile(x(x<xt & y > yt),0.85) | ...
    y < quantile(y(x<xt & y > yt),0.2));

% The good
good = x<xt & y>yt & ~weird;
if sum(good) >= 40
    good = x<quantile(x(x<xt),0.2) & y > quantile(y(y > xt),0.2);
end

% The borderline
weirdbad = (x>xt & x<2*quantile(x(x<xt),0.85)) | ...
    (y <= yt & y > 0);

% The bad
bad = (x>xt | y < yt) & ~weirdbad;
if numel(bad) >= 40
    bad = x>xt & y < yt;
end
            
