%INPUT: matrix containing bounding boxes (boxes) 
%OUTPUT: matrix containing relevant bounding boxes (nms)
function [nms] = nonMaxSupp(boxes)
    numBoxes = size(boxes,2);
    centers = zeros(numBoxes,2);
    for i = 1:numBoxes
       someBox = boxes(i).BoundingBox();
       box = floor(someBox);   
       x = box(1)+floor(box(3)/2);
       y = box(2)+floor(box(4)/2);
       centers(i,1) = x;
       centers(i,2) = y;
    end
    
    %10 clusters chosen arbitrarily
    clusterNum = 10;
    [k c] = kmeans(centers,clusterNum,'EmptyAction','Drop');
    c = floor(c);
    
    
    chosen = zeros(clusterNum,1); %chosen cluster numbers
    %eliminate excess boxes
  
    for j = 1:clusterNum
        clusterCenter = c(j);
        %assign first distance
        for i = 1:numBoxes
            if(k(i) == j) %in the cluster
                if(chosen(j) == 0)
                    chosen(j) = j;
                elseif( pdist([clusterCenter;centers(i)]) < pdist([clusterCenter;centers(chosen(j))]));
                    chosen(j) = i;
                end
            end
        end
    end
    
    nms = struct('BoundingBox',zeros(1,4));
    
    for i = 1:clusterNum
       chosen(i)
       if(chosen(i) > 0)
       someBox = boxes(chosen(i)).BoundingBox();
       box = floor(someBox); 
       nms(i).BoundingBox =  box;
       end  
    end
    
    for i = 1:clusterNum
        if(chosen(i) > 0)
        rectangle('Position',[nms(i).BoundingBox(1) ...
                            nms(i).BoundingBox(2) ...
                            nms(i).BoundingBox(3) ...
                            nms(i).BoundingBox(4)]);
        end
    end 
end


