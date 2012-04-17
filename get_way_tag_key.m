function [key, val] = get_way_tag_key(tag)
%
% See also PLOT_WAY, EXTRACT_CONNECTIVITY.
%
% File:         get_way_tag_key.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.21
% Language:     MATLAB R2011b
% Purpose:      get tags and key values for ways
% Copyright:    Ioannis Filippidis, 2010-

if isstruct(tag) == 1
    key = tag.Attributes.k;
    val = tag.Attributes.v;
elseif iscell(tag) == 1
    key = tag{1}.Attributes.k;
    val = tag{1}.Attributes.v;
else
    if isempty(tag)
        warning('Way has NO tag.')
    else
        warning('Way has tag which is not a structure nor cell array, but:')
        deisp(tag)
    end
    
    key = '';
    val = '';
end
