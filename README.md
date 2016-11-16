# CalculateCellHeight
自动计算cell高度、header、footer分区高度（frame计算）

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
  
  cell需要重写dp_getCellHeight方法

headerFooterView example：
  - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head_identifier];
    headerView.text = _dataSource[section][@"sectionTitle"];
    return headerView;
  }
  
  - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [tableView dp_heightForHeaderFooterViewReuseIdentifier:head_identifier configuration:^(id tempHeaderFooterView) {
        TableHeaderView *headerView = tempHeaderFooterView;
        headerView.text = _dataSource[section][@"sectionTitle"];
    }];
  }
  
  headerFooterView需要重写dp_getHeaderFooterViewHeight方法
  
