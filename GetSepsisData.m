function [feat] = GetSepsisData(input_file)


[values, column_names] = ReadChallengeData(input_file);


function [values, column_names] = ReadChallengeData(filename)
  f = fopen(filename, 'rt');
  try
    l = fgetl(f);
    column_names = strsplit(l, '|');
    values = dlmread(filename, '|', 1, 0);
  catch ex
    fclose(f);
    rethrow(ex);
  end
  fclose(f);
end
feat=values(:,1:40);
%labels=values(:,41);

  %% ignore SepsisLabel column if present
  %if strcmp(column_names(end), 'SepsisLabel')
  %  column_names = column_names(1:end-1);
  %  values = values(:,1:end-1);
  %end
end

