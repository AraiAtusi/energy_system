function A=ene_log_read(filename)
    T=csvRead(filename);
    M=[T(:,1:5),T(:,8:12),T(:,14:16)];
    T=zeros(size(M,'r'),7)
    T(:,1)=M(:,5)
    T(:,2)=M(:,6)
    T(:,3)=M(:,7)
    T(:,4)=M(:,13)
    T(:,5)=M(:,10)
    T(:,6)=M(:,9)
    T(:,7)=M(:,8)
    A=[T;%nan,%nan,nanmean(T(:,3)),%nan,%nan,nanmean(T(:,6)),nanmean(T(:,7));%nan,nansum(T(:,2)),%nan,nansum(T(:,4)),nansum(T(:,5)),%nan,%nan]
endfunction

function ene_log_write(M,filename)
    T=string(M);
    T=['時間','傾斜面日射量','気温','PV電力量','INV出力電力量','INV出力電流','INV出力電圧';T];
    T(size(T,'r')-1,1)='平均値';
    T(size(T,'r'),1)='合計値';
    T=strsubst(T,'Nan','');
    csvWrite(T,filename);
endfunction

function ene_log_to_csv()
    cd('data');
    DirectoryArray=ls();//201205,201206..
    mkdir('temp');
    for i=1:size(DirectoryArray,'r')
        FilenameArray=ls(DirectoryArray(i));//11111DMS12050101.log,11111DMS...
        for j=1:size(FilenameArray,'r')
            if strindex(FilenameArray(j),'DMS') then
                readFilename=DirectoryArray(i)+'/'+FilenameArray(j);
                writeFilename="20"+strsubst(strsubst(FilenameArray(j),'11111DMS',''),'log','csv');

                T=ene_log_read(readFilename);
                ene_log_write(T,'temp/'+writeFilename)
            end
        end
    end
    cd("..")
endfunction

function ene_join_hour_to_day()
endfunction
