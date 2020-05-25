function template = parseNCTemplate ( file )
%PARSETEMPLATE Parses the given NetCDF attribute template file.
% Simplified from the IMOS toolbox parseNetCDFTemplate.m (RC, 2020)
%
% Parses the given NetCDF attribute template file, inserting data into 
% the given sample_data struct where required. 
%
%   == Attribute definition ==
%
% The syntax of an attribute definition is of the form:
%
%   type, attribute_name = attribute_value
%
% where type is the type of the attribut, attribute_name is the CCHDO 
% compliant NetCDF attribute name, and attribute_value is the value that the 
% attribute should be given. Attributes can be one of the following types:
%
%   S - String
%   N - Numeric
%   D - Date (in format 'yyyy-mm-ddTHH:MM:SS')
%
%   == Value definition ==
%
% The attribute_value field has a syntax of its own. It can be a plain string
% (without quotes),or can be empty, in which case it will either be filled or a warning given.
%
% Inputs:
%   file        - name of the template file to parse.
%
% Outputs:
%   template    - Struct containing the attribute-value pairs that were 
%                 defined in the template file.
%
% Author: Rebecca Cowley rebecca.cowley@csiro.au
%       (original IMOS Author) Paul McCarthy <paul.mccarthy@csiro.au>
%
  narginchk(1, 1);
 
  if ~ischar(file),                error('file must be a string');        end

  dateFmt = 'yyyy-mm-ddTHH:MM:SS';
  
  fid = -1;

  try 
    % open file for reading
    fid = fopen(file, 'rt');
    line = '';
    if fid == -1, error(['couldn''t open ' file ' for reading']); end
        
    % read in and parse each line
    line = fgetl(fid);
    while ischar(line)

      % extract the attribute name and value
      tkns = regexp(line, ...
        '^\s*(.*\S)\s*,\s*(.*\S)\s*=\s*(.*\S)?\s*$', 'tokens');

      % ignore bad lines
      if isempty(tkns), 
        line = fgetl(fid);
        continue; 
      end

      type = tkns{1}{1};
      name = tkns{1}{2};
      val  = tkns{1}{3};

      % Parse the value, put it into the template struct.
      template.(name) = [];
      template.(name) = val;
      
      % cast to correct type
      template.(name) = castAtt(template.(name), type, dateFmt);

      % get the next line
      line = fgetl(fid);
    end

    fclose(fid);
  catch e
    if fid ~= -1, fclose(fid); end
    disp(line);
    rethrow(e);
  end
end

function value = castAtt(value, t, dateFmt)
%CASTATT Given a string, translates it into the type specified by t, where
% t is one of the attribute types S, N, D, or Q.
%
% Inputs:
%   value   - A string.
%   t       - the attribute type to cast to.
%   dateFmt - Format in which to expect values of type 'D'. Matlab serial
%             dates are accepted in addition to this format.
%
% Outputs:
%
%   value - If the input was a string, and that string contained a scalar 
%           numeric, returns a scalar numeric. Otherwise returns the input 
%           unchanged.
%
  switch t
    case 'S', value = value;
    case 'N'
      if isempty(value)
          value = []; 
          return;
      end
      
      % in case several values
      value = textscan(value, '%s');
      value = str2double(value{1});
      
      if isnan(value), value = []; end
    case 'D'
      
      % for dates, try to use provided date format, 
      % otherwise assume it is matlab serial
      val = [];
      try 
          if ~isempty(value)
            val = datenum(value, dateFmt);
          end
      catch
          val = str2double(value);
      end
      value = val;
      
      if isnan(value), value = []; end
      
  end
end
