# CalculateCellHeight
自动计算cell高度、header、footer分区高度

cell example：
  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    cell.dict = _dataSource[indexPath.section][@"list"][indexPath.row];
    return cell;
  }
  
  - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dp_heightForCellWithIdentifier:cell_identifier configuration:^(id tempCell) {
        TableViewCell *cell = tempCell;
        cell.dict = _dataSource[indexPath.section][@"list"][indexPath.row];
    }];
  }
