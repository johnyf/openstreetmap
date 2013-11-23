function [key, val] = get_way_tag_key(tag)
% get tags and key values for ways
%
% 2010.11.21 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also PLOT_WAY, EXTRACT_CONNECTIVITY.

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
        disp(tag)
    end
    
    key = '';
    val = '';
end
