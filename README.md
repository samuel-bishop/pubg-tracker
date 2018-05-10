# rPUBG_API

<Window x:Class="MyPaint.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:MyPaint"
        mc:Ignorable="d"
        Title="Paint" Height="800" Width="1250"
        Loaded="Window_Loaded">

    <DockPanel>
        <StackPanel DockPanel.Dock="Top">
            <Menu>
                <MenuItem Header="File">
                    <MenuItem Header="Save" Click="saveClick"/>
                    <MenuItem Header="Load" Click="loadClick"/>
                </MenuItem>
                <MenuItem Header="About" Click="aboutClick"/>
                <MenuItem Header="Exit" Click="exitClick"/>
                <Button x:Name="undoButton" Click="undoClick" Background="LightGray">Undo</Button>
            </Menu>

            <ToolBarTray Background="Gray" Height="67" Margin="0,0,0.2,0">
                <ToolBar Band="1" BandIndex="1" Margin="0,0,0.8,-7.2" Background="Black" >
                    <Menu Width="596" Margin="0,5,0,24.8">

                        <Button x:Name="pencilButton" Click="setPencil" Width="50" BorderThickness="2" BorderBrush="Black">
                            Pencil
                        </Button>
                        <Button x:Name="eraserButton" Click="setEraser" Width="50" BorderThickness="2" BorderBrush="Black">
                            Eraser
                        </Button>

                        <StackPanel Orientation="Horizontal" Background="LightGray" Width="105" Margin="1, 1, 1, 1">
                            <StackPanel Orientation="Vertical">
                                <Button x:Name="white" Background="White" Click="white_click" Height="20" Width="20" BorderBrush="black"></Button>
                                <Button x:Name="black" Background="Black" Foreground="White" Click="black_Click" Height="20" Width="20" BorderBrush="black"></Button>
                            </StackPanel>
                            <StackPanel Orientation="Vertical">
                                <Button  x:Name="red" Background="Red" Margin="0,0,-0.4,0" Click="red_click" Height="20" Width="20" BorderBrush="black"></Button>
                                <Button  x:Name="blue" Background="Blue" Click="blue_click" Height="20" Width="20" BorderBrush="black"></Button>
                            </StackPanel>
                            <StackPanel Orientation="Vertical">
                                <Button  x:Name="green" Background="Green" Click="green_click" Height="20" Width="20" BorderBrush="black"></Button>
                                <Button  x:Name="yellow" Background="Yellow" Click="yellow_click" Height="20" Width="20" BorderBrush="black"></Button>
                            </StackPanel>
                            <StackPanel Orientation="Vertical">
                                <Button  x:Name="brown" Background="Brown" Foreground="white" Click="brown_click" Height="20" Width="20" BorderBrush="black"></Button>
                                <Button  x:Name="pink" Background="Pink" Click="pink_click" Height="20" Width="20" BorderBrush="black"></Button>
                            </StackPanel>
                            <StackPanel Orientation="Vertical">
                                <Button  x:Name="purple" Background="Purple" Foreground="White" Click="purple_Click" Height="20" Width="20" BorderBrush="black"></Button>
                                <Button  x:Name="orange" Background="Orange" Click="orange_click" Height="20" Width="20" BorderBrush="black"></Button>
                            </StackPanel>
                         
                        </StackPanel>

                        <Button x:Name="currentColor" Width="25" Height="25" Background="Black">

                        </Button>
                      
                        Size:
                        <StackPanel Orientation="Vertical">
                            <Slider x:Name="sizeSlider" HorizontalAlignment="Right" VerticalAlignment="Center" BorderBrush="Black" BorderThickness="1" ValueChanged="setSize" Width="100" Minimum="2" Maximum="30" Value="2" />
                            <Button x:Name="fillButton" BorderThickness="2" BorderBrush="Black" Click="setFill" Width="25" Margin="1,6, 0, 0">Fill</Button>
                        </StackPanel>
                        <StackPanel Background="Gray" Width="46" Height="45" Orientation="Horizontal">
                            <StackPanel Orientation="Vertical">
                                <Button x:Name="lineButton" HorizontalAlignment="Left" BorderThickness="2" BorderBrush="Black" Width="22" Height="22" Click="setLine" >
                                    <Polygon Points="8, 8 7, 7" Stroke="Black" StrokeThickness="1.5">
                                        
                                    </Polygon>
                                </Button>
                                <Button x:Name="rectangleButton" HorizontalAlignment="Left" BorderThickness="2" BorderBrush="Black" Width="22" Height="22" Click="setRectangle" >
                                    <Rectangle Visibility="Visible" Height="10" Width="10" Fill="Black" />
                                </Button>
                            </StackPanel>

                            <StackPanel Orientation="Vertical">
                                <Button x:Name="ellipseButton" HorizontalAlignment="Right" BorderThickness="2" BorderBrush="Black" Width="22" Height="22" Click="setEllipse" >
                                    <Ellipse Visibility="Visible" Height="10" Width="10" Fill="Black"/>
                                </Button>
                                <Button x:Name="triangleButton" HorizontalAlignment="Right" BorderThickness="2" BorderBrush="Black" Width="22" Height="22" Click="setTriangle" >
                                    <Polygon Points="10, 0 0, 10 10, 10" Stroke="Black" StrokeThickness="1">
                                        <Polygon.Fill>
                                            <SolidColorBrush Color="Black"/>
                                        </Polygon.Fill>
                                    </Polygon>
                                </Button>

                            </StackPanel>
                        </StackPanel>
                        <Button x:Name="clearButton" Click="clearClick" Width="47">
                            Clear
                        </Button>

                    </Menu>
                </ToolBar>
            </ToolBarTray>
        </StackPanel>
        <Canvas x:Name="myCanvas" Background="White" PreviewMouseDown="Canvas_MouseDown" PreviewMouseUp="Canvas_MouseUp" PreviewMouseMove="Canvas_MouseMove">
        </Canvas>
    </DockPanel>
</Window>
