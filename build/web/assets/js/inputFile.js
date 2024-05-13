

function _extends() {_extends = Object.assign || function (target) {for (var i = 1; i < arguments.length; i++) {if (window.CP.shouldStopExecution(1)) break;var source = arguments[i];for (var key in source) {if (Object.prototype.hasOwnProperty.call(source, key)) {target[key] = source[key];}}}window.CP.exitedLoop(1);return target;};return _extends.apply(this, arguments);}console.clear();
                            const formatBytes = (bytes, decimals = 2) => {
                            if (bytes === 0) return '0 Bytes';

                            const k = 1000;
                            const dm = decimals < 0 ? 0 : decimals;
                            const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

                            const i = Math.floor(Math.log(bytes) / Math.log(k));

                            return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
                            };

                            const useFileReader = files => {

                            const [images, setImages] = React.useState([]);

                            React.useEffect(() => {
                                const fileReaders = [];
                                let isCancel = false;

                                const promises = files.map(file => {
                                return new Promise((resolve, reject) => {
                                    const fileReader = new FileReader();
                                    fileReaders.push(fileReader);
                                    fileReader.onload = e => {
                                    const { result } = e.target;
                                    if (result) {
                                        resolve({
                                        name: file.name,
                                        size: file.size,
                                        formatSize: formatBytes(file.size),
                                        type: file.type,
                                        url: result });

                                    }
                                    };
                                    fileReader.onabort = () => {
                                    reject(new Error("File reading aborted"));
                                    };
                                    fileReader.onerror = () => {
                                    reject(new Error("Failed to read file"));
                                    };
                                    fileReader.readAsDataURL(file);
                                });
                                });

                                Promise.
                                all(promises).
                                then(images => {
                                if (!isCancel) {
                                    setImages(images);
                                }
                                }).
                                catch(reason => {
                                console.log(reason);
                                });

                                return () => {
                                isCancel = true;
                                fileReaders.forEach(fileReader => {
                                    if (fileReader.readyState === 1) {
                                    fileReader.abort();
                                    }
                                });
                                };
                            }, [files]);

                            return images;
                            };

                            const DragAndDropFiles = props => {

                            const {
                                label, id,
                                accept,
                                multiple = false,
                                limitSize = 5000000,
                                errorTimeout = 3000,
                                ...inputProps } =
                            props;

                            const [files, setFiles] = React.useState([]);
                            const [error, setError] = React.useState(null);
                            const images = useFileReader(files);

                            React.useEffect(() => {
                                let intervalId = null;

                                if (error !== null) {
                                intervalId = setTimeout(() => {
                                    setError(null);
                                }, errorTimeout);
                                }

                                return () => {
                                if (intervalId !== null) {
                                    clearTimeout(intervalId);
                                }
                                };
                            }, [error]);

                            const saveFiles = files => {
                                for (let i = 0; i < files.length; i++) {if (window.CP.shouldStopExecution(0)) break;
                                const file = files.item(i);
                                if (file.size < limitSize) {
                                    setFiles(prev => [...prev, file]);
                                } else {
                                    setError(`File '${file.name}' size is larger than ${formatBytes(limitSize)}`);
                                }
                                }window.CP.exitedLoop(0);
                            };

                            const handleChange = e => {
                                const { files } = e.target;
                                saveFiles(files);
                            };

                            const handleDrop = e => {
                                e.preventDefault();
                                e.stopPropagation();
                                if (e.dataTransfer.files && e.dataTransfer.files.length) {
                                saveFiles(e.dataTransfer.files);
                                }
                            };

                            const getIconType = type => {var _iconTypes$type;
                                const iconTypes = {
                                'image/png': 'fa-file-image',
                                'application/pdf': 'fa-file-pdf' };


                                return (_iconTypes$type = iconTypes[type]) !== null && _iconTypes$type !== void 0 ? _iconTypes$type : 'fa-file';
                            };

                            const deleteFile = index => {
                                const copy = [...files];
                                copy.splice(index, 1);
                                setFiles(copy);
                            };

                            const totalSize = React.useMemo(() =>
                            files.reduce((prev, { size }) => prev + size, 0),
                            [files]);

                            return /*#__PURE__*/(
                                React.createElement("section", { className: "input-file" }, /*#__PURE__*/
                                React.createElement("section", {
                                className: "input-file--box",
                                onDrop: handleDrop }, /*#__PURE__*/

                                React.createElement("i", { className: "fa fa-cloud-arrow-up input-file--icon" }), /*#__PURE__*/
                                React.createElement("label", { htmlFor: id }, label), /*#__PURE__*/
                                React.createElement("span", null, "Max size (", formatBytes(limitSize), ")"), /*#__PURE__*/
                                React.createElement("input", _extends({},
                                inputProps, {
                                id: id,
                                type: "file",
                                accept: accept,
                                multiple: true,
                                onChange: handleChange }))),


                                error !== null && /*#__PURE__*/React.createElement("span", { className: "error" }, error), /*#__PURE__*/
                                React.createElement("span", { className: "total-info" }, files.length, " files - ", formatBytes(totalSize)), /*#__PURE__*/
                                React.createElement("section", { className: "input-file--files" },

                                images.map((image, key) => /*#__PURE__*/
                                React.createElement("section", { key: key, className: "image-card" }, /*#__PURE__*/
                                React.createElement("section", { className: "image-card--image" }, /*#__PURE__*/
                                React.createElement("i", { className: `fa ${getIconType(image.type)} image-card--icon` })), /*#__PURE__*/

                                React.createElement("section", { className: "image-card--data" }, /*#__PURE__*/
                                React.createElement("p", { className: "image-card--name" }, image.name), /*#__PURE__*/
                                React.createElement("p", { className: "image-card--size", title: `${image.size} bytes` }, image.formatSize)), /*#__PURE__*/

                                React.createElement("section", { className: "image-card--delete", onClick: () => deleteFile(key) }, /*#__PURE__*/
                                React.createElement("i", { className: "fa fa-trash-can image-card--delete--icon" })))))));







                            };

                            const App = () => {
                            return /*#__PURE__*/(
                                React.createElement("section", null, /*#__PURE__*/
                                React.createElement(DragAndDropFiles, {
                                label: "Click to upload or drag and drop",
                                id: "file",
                                limitSize: 5000000 })));



                            };

                            // ReactDOM.createRoot(
                            // document.getElementById('root')).
                            // render( /*#__PURE__*/
                            // React.createElement(React.StrictMode, null, /*#__PURE__*/
                            // React.createElement(App, null)));

                            ReactDOM.render(
                                React.createElement(React.StrictMode, null, React.createElement(App, null)),
                                document.getElementById('root')
                            );