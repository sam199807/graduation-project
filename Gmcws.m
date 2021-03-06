function rf=Gmcws(rf,demand,dis,saving,capacity,num_m,limit,d,loc) 
n=size(rf,1); 
m=size(rf,2); 
e=size(saving,1); 
ds=reshape(saving,1,e^2); 
[c,I]=sort(ds,'descend');
[o,p]=ind2sub(size(saving),I); 
 
for i=1:size(o,2) 
Cf=[]; 
     if saving(o(i),p(i))>0 
     if find(rf==o(i))   
         if find(rf==p(i)) 
         if o(i)>(1+num_m) 
             [x1 y1]=find(rf==o(i)); 
             [x2 y2]=find(rf==p(i)); 
             if x1~=x2 
             if (y1==2|rf(x1,y1+1)==1)&(y2==2|rf(x2,y2+1)==1) 
                 sum=0; 
                 for j=1:m 
                     if rf(x1,j)>1+num_m 
                         sum=sum+demand(rf(x1,j)-1-num_m); 
                     end 
                     if rf(x2,j)>1+num_m 
                         sum=sum+demand(rf(x2,j)-1-num_m); 
                     end 
                 end 
                 if sum<=capacity 
                     if y1==2 & y2==2 
                         R=rf(x1,:); 
                         R=fliplr(R); 
                         C=[R rf(x2,:)]; 
                         d1=find(C==1); 
                         C(d1)=[]; 
                          
                     elseif y1==2 & rf(x2,y2+1)==1 
                         C=[rf(x2,:) rf(x1,:)]; 
                         d1=find(C==1); 
                         C(d1)=[]; 
                     elseif (rf(x1,y1+1)==1)&(rf(x2,y2+1)==1) 
                          R=rf(x2,:); 
                          R=fliplr(R); 
                          C=[rf(x1,:) R]; 
                          d1=find(C==1); 
                          C(d1)=[]; 
                     elseif rf(x1,y1+1)==1&y2==2
                        C=[rf(x1,:) rf(x2,:)]; 
                        d1=find(C==1); 
                        C(d1)=[]; 
                     end 
                  
                 C=[1 C 1]; 
                 fe=testr(C,num_m,limit,dis); 
                 if fe==0 
                     rf(x1,1:size(C,2))=C; 
                     rf(x2,:)=1; 
                 elseif fe==1 
                     d_c=2*d; 
                     for k1=1:size(loc,2) 
                       po=find(C==o(i)); 
                       if C(po+1)==p(i) 
                           C=[C 1]; 
                           for k=size(C,2):-1:po+2 
                             C(k)=C(k-1); 
                           end 
                           C(po+1)=loc(k1); 
                       elseif   C(po-1)==p(i) 
                           C=[C 1]; 
                           for k=size(C,2):-1:po+1 
                             C(k)=C(k-1); 
                           end 
                           C(po)=loc(k1); 
                       end 
                       if testr(C,num_m,limit,dis)==0&dis(loc(k1),p(i))+dis(loc(k1),o(i))<d_c 
                         d_c=dis(loc(k1),p(i))+dis(loc(k1),o(i)); 
                           Cf=C; 
                       end 
                     end 
                     if Cf 
                         rf(x1,1:length(Cf))=Cf; 
                         rf(x2,:)=1; 
                     else 
                     end 
                 end 
                 end 
             end
             end
         elseif o(i)<=(1+num_m)&p(i)>(1+num_m) 
             [x1 y1]=find(rf==o(i)); 
             [x2 y2]=find(rf==p(i)); 
             if y2==2|rf(x2,y2+1)==1 
                 k2=size(x1,1); 
                 for j0=1:k2 
                     if x1(j0)~=x2&(y1(j0)==2|rf(x1(j0),y1(j0))==1) 
                         sum=0; 
                         for j=1:m 
                             if rf(x1(j0),j)>1+num_m 
                             sum=sum+demand(rf(x1(j0),j)-1-num_m); 
                             end 
                             if rf(x2,j)>1+num_m 
                                 sum=sum+demand(rf(x2,j)-1-num_m); 
                             end 
                         end 
                         if sum<=capacity 
                             if y1(j0)==2 & y2==2 
                                 R=rf(x1(j0),:); 
                                 R=fliplr(R); 
                                 C=[R rf(x2,:)]; 
                                 d1=find(C==1); 
                                 C(d1)=[]; 
                             elseif y1(j0)==2 & rf(x2,y2+1)==1 
                             C=[rf(x2,:) rf(x1(j0),:)]; 
                             d1=find(C==1); 
                             C(d1)=[]; 
                             elseif (rf(x1(j0),y1(j0)+1)==1)&(rf(x2,y2+1)==1) 
                              R=rf(x2,:); 
                              R=fliplr(R); 
                              C=[rf(x1(j0),:) R]; 
                              d1=find(C==1); 
                              C(d1)=[]; 
                              elseif rf(x1(j0),y1(j0)+1)==1&y2==2 
                              C=[rf(x1(j0),:) rf(x2,:)]; 
                              d1=find(C==1); 
                              C(d1)=[]; 
                             end
                         C=[1 C 1]; 
                         fe=testr(C,num_m,limit,dis); 
                         if fe==0 
                           rf(x1(j0),1:size(C,2))=C; 
                           rf(x2,:)=1; 
                           break; 
                         elseif fe==1 
                            d_c=2*d; 
                            Cf=[C 1]; 
                     for k1=1:size(loc,2) 
                       po=find(C==o(i)); 
                       if C(po+1)==p(i) 
                           C=[C 1]; 
                           for k=size(C,2):-1:po+2 
                             C(k)=C(k-1); 
                           end 
                           C(po+1)=loc(k1); 
                       elseif   C(po-1)==p(i) 
                           C=[C 1]; 
                           for k=size(C,2):-1:po+1 
                             C(k)=C(k-1); 
                           end 
                           C(po)=loc(k1); 
                       end 
                       if testr(C,num_m,limit,dis)==0&&dis(loc(k1),p(i))+dis(loc(k1),o(i))<d_c
                           d_c=dis(loc(k1),p(i))+dis(loc(k1),o(i)); 
                           Cf=C; 
                       end 
                     end 
                     if Cf 
                         rf(x1(j0),1:length(Cf))=Cf; 
                         rf(x2,:)=1; 
                         break; 
                     else 
                     end   
                         end                    
                         end 
                     end 
                 end 
             end
         elseif p(i)<=1+num_m 
              if o(i)~=p(i) 
                  p0=1; 
                  while p0>0 
                      p0=0; 
                      [x1 y1]=find(rf==o(i)); 
                      [x2 y2]=find(rf==p(i)); 
                  for k1=1:size(x1,1) 
                      for k2=1:size(x2,1) 
                          if x1(k1)~=x2(k2)&&(y1(k1)==2|rf(x1(k1),y1(k1)+1)==1)&(y2(k2)==2|rf(x2(k2),y2(k2)+1)==1) 
                                  sum=0; 
                                  for j=1:m 
                                      if rf(x1(k1),j)>1+num_m 
                                       sum=sum+demand(rf(x1(k1),j)-1-num_m); 
                                      end 
                                      if rf(x2(k2),j)>1+num_m 
                                          sum=sum+demand(rf(x2(k2),j)-1-num_m); 
                                      end 
                                  end 
                                 if sum<=capacity 
                                     if y1(k1)==2 & y2(k2)==2 
                                          R=rf(x1(k1),:); 
                                          R=fliplr(R); 
                                          C=[R rf(x2(k2),:)]; 
                                          d1=find(C==1); 
                                          C(d1)=[]; 
                                     elseif y1(k1)==2 & rf(x2(k2),y2(k2)+1)==1 
                                            C=[rf(x2(k2),:) rf(x1(k1),:)]; 
                                            d1=find(C==1); 
                                            C(d1)=[]; 
                                     elseif (rf(x1(k1),y1(k1)+1)==1)&(rf(x2(k2),y2(k2)+1)==1)
                                            R=rf(x2(k2),:); 
                                            R=fliplr(R); 
                                           C=[rf(x1(k1),:) R]; 
                                           d1=find(C==1); 
                                           C(d1)=[]; 
                                     elseif rf(x1(k1),y1(k1)+1)==1&y2(k2)==2 
                                            C=[rf(x1(k1),:) rf(x2(k2),:)]; 
                                            d1=find(C==1);
                                            C(d1)=[]; 
                                     end 
                                
                         C=[1 C 1]; 
                           fe=testr(C,num_m,limit,dis); 
                         if fe==0 
                           rf(x1(k1),1:size(C,2))=C; 
                           rf(x2(k2),:)=1; 
                           p0=p0+1; 
                           break 
                         elseif fe==1 
                            d_c=2*d; 
                            for k0=1:size(loc,2) 
                                if loc(k0)~=o(i)&loc(k0)~=p(i) 
                                     po=find(C==o(i)); 
                                     if C(po+1)==p(i) 
                                     C=[C 1]; 
                                      for k=size(C,2):-1:po+2 
                                       C(k)=C(k-1); 
                                      end 
                                       C(po+1)=loc(k1); 
                                     elseif   C(po-1)==p(i) 
                                     C=[C 1]; 
                                       for k=size(C,2):-1:po+1 
                                       C(k)=C(k-1); 
                                       end 
                                          C(po)=loc(k1); 
                                     end 
                                      if testr(C,num_m,limit,dis)==0&dis(loc(k0),p(i))+dis(loc(k0),o(i))<d_c 
                                          d_c=dis(loc(k0),p(i))+dis(loc(k0)); 
                                       Cf=C; 
                                      end 
                                end 
                            end 
                                if Cf 
                                   rf(x1(j0),1:length(Cf))=Cf; 
                                   rf(x2,:)=1; 
                                   p0=p0+1; 
                                   break;
                                else 
                                end 
                            end 
                          
                                 end 
                          end 
                      end 
                      if p0==1 
                          break; 
                      end 
                  end 
                  end 
              elseif o(i)==p(i) 
                  p0=1; 
                  while p0>0 
                      p0=0; 
                     [ x1 y1]=find(rf==o(i)); 
                     for k1=1:size(x1,1) 
                         for k2=k1+1:size(x1,1) 
                             if x1(k1)~=x1(k2) 
                                if( y1(k1)==2|rf(x1(k1),y1(k1)+1)==1)&( y1(k2)==2|rf(x1(k2),y1(k2)+1)==1) 
                                     sum=0; 
                                     for j=1:m 
                                      if rf(x1(k1),j)>1+num_m 
                                       sum=sum+demand(rf(x1(k1),j)-1-num_m); 
                                      end 
                                      if rf(x1(k2),j)>1+num_m 
                                          sum=sum+demand(rf(x1(k2),j)-1-num_m); 
                                      end 
                                     end 
                                     if sum<=capacity 
                                         if y1(k1)==2 & y1(k2)==2 
                                          R=rf(x1(k1),:); 
                                          R(1,2)=1; 
                                          R=fliplr(R); 
                                          C=[R rf(x1(k2),:)]; 
                                          d1=find(C==1); 
                                          C(d1)=[]; 
                                         elseif y1(k1)==2 & rf(x1(k2),y1(k2)+1)==1
                                              R=rf(x1(k1),:); 
                                             R(1,y1(k1))=1; 
                                            C=[rf(x1(k2),:) R]; 
                                            d1=find(C==1); 
                                            C(d1)=[]; 
                                          elseif (rf(x1(k1),y1(k1)+1)==1)&(rf(x1(k2),y1(k2)+1)==1) 
                                            R=rf(x1(k2),:); 
                                            R(1,y1(k2))=1; 
                                            R=fliplr(R); 
                                           C=[rf(x1(k1),:) R]; 
                                           d1=find(C==1); 
                                           C(d1)=[]; 
                                           elseif rf(x1(k1),y1(k1)+1)==1&y1(k2)==2 
                                                R=rf(x1(k1),:); 
                                             R(1,y1(k1))=1; 
                                            C=[R rf(x1(k2),:)]; 
                                            d1=find(C==1); 
                                            C(d1)=[]; 
                                         end 
                                           C=[1 C 1]; 
                                           rf(x1(k1),1:size(C,2))=C; 
                                           rf(x1(k2),:)=1; 
                                           p0=p0+1; 
                                           break; 
                                     end 
                                 end 
                             end 
                         end 
                         if p0==1 
                             break; 
                         end 
                     end 
                  end 
              end 
         end 
     end 
     end 
     end
end
pr=1; 
while pr>0 
     pr=0; 
D1=ones(1,size(rf,2)-1); 
for i=1:size(rf,1) 
     lengthd=inf; 
     pd=0; 
     if rf(i,2)~=1 
         for j=1:size(rf,2) 
             if rf(i,j)>=2&rf(i,j)<=1+num_m 
                 C=rf(i,:); 
                 C(j)=[]; 
                 fe=testr(C,num_m,limit,dis); 
                 if fe==0 
                     lengthc=disr(C,dis); 
                     if lengthc<lengthd 
                         lengthd=lengthc; 
                         D1=C; 
                         pd=1; 
                     end 
                 end 
             end 
         end   
         if pd==1 
         rf(i,1:size(D1,2))=D1; 
         pr=1; 
         end
     end 
   
end       
end 
